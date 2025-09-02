-- ER diagram: See the Mermaid chart for a visual of the database schema:
-- https://www.mermaidchart.com/app/projects/ab37573f-f236-4a92-a05e-685ff634e6da/diagrams/49196a84-fea2-497d-b760-4ff6ab5f59aa/version/v0.1/edit



CREATE SCHEMA IF NOT EXISTS staging AUTHORIZATION analyst;
GRANT USAGE ON SCHEMA public TO analyst;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO analyst;

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public
GRANT SELECT, INSERT, UPDATE ON TABLES TO analyst;

-- ===============================================================================================
-- DIMENSION TABLES 
-- ===============================================================================================

CREATE TABLE IF NOT EXISTS dim_country (
  country_code TEXT PRIMARY KEY,        
  country_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_gas (
  gas_code TEXT PRIMARY KEY,             
  gas_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_sector (
  cpa_code  TEXT PRIMARY KEY,            
  cpa_label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_indicator (
  indicator_code  TEXT PRIMARY KEY,      
  indicator_label TEXT NOT NULL,
  unit            TEXT NOT NULL         
);

-- ===============================================================================================
-- FACT TABLES + INDEXes
-- ===============================================================================================

CREATE TABLE IF NOT EXISTS fact_emissions_total_annual (
  country_code TEXT NOT NULL REFERENCES dim_country(country_code),
  year         INT  NOT NULL,
  gas_code     TEXT NOT NULL REFERENCES dim_gas(gas_code),
  value_ktco2e NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year, gas_code)
);

CREATE INDEX IF NOT EXISTS idx_total_country_year
  ON fact_emissions_total_annual (country_code, year);


CREATE TABLE IF NOT EXISTS fact_emissions_intensity_annual (
  country_code   TEXT NOT NULL REFERENCES dim_country(country_code),
  year           INT  NOT NULL,
  indicator_code TEXT NOT NULL REFERENCES dim_indicator(indicator_code),
  value          NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year, indicator_code)
);

CREATE INDEX IF NOT EXISTS idx_intensity_country_year
  ON fact_emissions_intensity_annual (country_code, year);


CREATE TABLE IF NOT EXISTS fact_emissions_index_annual (
  country_code TEXT NOT NULL REFERENCES dim_country(country_code),
  year         INT  NOT NULL,
  index_value  NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year)
);

CREATE INDEX IF NOT EXISTS idx_index_country_year
  ON fact_emissions_index_annual (country_code, year);


CREATE TABLE IF NOT EXISTS fact_emissions_sector_annual (
  country_code TEXT NOT NULL REFERENCES dim_country(country_code),
  year         INT  NOT NULL,
  cpa_code     TEXT NOT NULL REFERENCES dim_sector(cpa_code),
  value_ktco2e NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year, cpa_code)
);

CREATE INDEX IF NOT EXISTS idx_sector_country_year
  ON fact_emissions_sector_annual (country_code, year);


CREATE TABLE IF NOT EXISTS fact_emissions_percapita_annual (
  country_code    TEXT NOT NULL REFERENCES dim_country(country_code),
  year            INT  NOT NULL,
  value_t_per_cap NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year)
);

CREATE INDEX IF NOT EXISTS idx_percap_country_year
  ON fact_emissions_percapita_annual (country_code, year);


CREATE TABLE IF NOT EXISTS fact_emissions_total_quarterly (
  country_code TEXT NOT NULL REFERENCES dim_country(country_code),
  year         INT  NOT NULL,
  quarter      INT  NOT NULL CHECK (quarter BETWEEN 1 AND 4),
  value_ktco2e NUMERIC NOT NULL,
  PRIMARY KEY (country_code, year, quarter)
);

CREATE INDEX IF NOT EXISTS idx_quarterly_country_yq
  ON fact_emissions_total_quarterly (country_code, year, quarter);
  