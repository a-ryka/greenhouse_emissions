GRANT USAGE, CREATE ON SCHEMA public TO analyst;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO analyst;


-- Trend in total emissions (GHG)
CREATE OR REPLACE VIEW v_eu_total_annual AS
SELECT year, value_ktco2e
FROM fact_emissions_total_annual
WHERE country_code='EU27_2020' AND gas_code='GHG'
ORDER BY year;

-- Structure by CPA + shares
CREATE OR REPLACE VIEW v_eu_sector_shares AS
WITH tot AS (
  SELECT year, value_ktco2e AS total_yr
  FROM fact_emissions_total_annual
  WHERE country_code='EU27_2020' AND gas_code='GHG'
)
SELECT s.year, s.cpa_code, s.value_ktco2e,
       s.value_ktco2e / tot.total_yr AS share
FROM fact_emissions_sector_annual s
JOIN tot USING (year)
WHERE s.country_code='EU27_2020';

-- Ranking of countries by per capita in the last year
CREATE OR REPLACE VIEW v_country_percapita_latest AS
WITH y AS (SELECT MAX(year) AS y FROM fact_emissions_percapita_annual)
SELECT p.country_code, p.year, p.value_t_per_cap
FROM fact_emissions_percapita_annual p, y
WHERE p.year = y.y
ORDER BY p.value_t_per_cap DESC;

-- Intensity indicators by country (convenient summary)
CREATE OR REPLACE VIEW v_intensity_pivot AS
SELECT country_code, year,
       MAX(CASE WHEN indicator_code='G_KM' THEN value END)  AS g_km,
       MAX(CASE WHEN indicator_code='G_GDP' THEN value END) AS g_gdp,
       MAX(CASE WHEN indicator_code='G_POP' THEN value END) AS g_pop
FROM fact_emissions_intensity_annual
GROUP BY country_code, year;

-- Quarterly YoY changes
CREATE OR REPLACE VIEW v_eu_quarterly_yoy AS
SELECT country_code, year, quarter, value_ktco2e,
       value_ktco2e
       / NULLIF(LAG(value_ktco2e) OVER (PARTITION BY country_code, quarter ORDER BY year),0) - 1
       AS yoy
FROM fact_emissions_total_quarterly
WHERE country_code='EU27_2020';


-- Emissions by country (sum of all quarter)
CREATE OR REPLACE VIEW v_country_emissions_annual AS
SELECT 
    country_code,
    year,
    SUM(value_ktco2e) AS value_ktco2e_annual
FROM fact_emissions_total_quarterly
GROUP BY country_code, year
ORDER BY country_code, year;





-- only if they are no longer needed for debugging

DROP TABLE IF EXISTS public.staging_emissions_total;
DROP TABLE IF EXISTS public.staging_emissions_intensity;
DROP TABLE IF EXISTS public.staging_emissions_index;
DROP TABLE IF EXISTS public.staging_emissions_sector;
DROP TABLE IF EXISTS public.staging_emissions_percapita;
DROP TABLE IF EXISTS public.staging_emissions_quarterly;


