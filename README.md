# Greenhouse Gas Emissions Analysis

👋 Hi! I am Anastasiia, Bachelor student in Computer Science at the University of Vienna, and this project presents an analysis of greenhouse gas (GHG) emissions in the European Union (EU27) using official statistical data.  

The project combines data collection, processing, and visualization:
- **PostgreSQL** database was created to store and organize the data.
- **Python** (Jupyter Notebook) was used for data cleaning, transformation, and preparation.
- **Tableau** was used to design an interactive dashboard with multiple visualizations.
- **Mermaidchart** was used to design an ERM of database.

---

### Project Structure
```
greenhouse_gas_emissions
│
├── data/
│ ├── raw/ # Original datasets (as downloaded)
│ ├── processed/ # Cleaned and transformed datasets
│
├── sql/
│ ├── 01_create_db.sql # Database schema (dim & fact tables, indexes, constraints)
│ ├── 02_create_view.sql # Views for easier analysis (shares, per capita, intensities)
│
├── notebooks/
│ ├── data_formatting.ipynb # Cleaning & preparing raw data
│ ├── data_load_into_db.ipynb # Loading data into PostgreSQL
│ ├── greenhouse_emissions_analysis.ipynb # Exploratory analysis & visualization
│ ├── figs/ # Exported plots and charts
│
├── dashboard/
│ └── greenhouse_emissions.twb # Tableau dashboard file
│
└── README.md # Project documentation
```

## Data Sources & Links

- **Eurostat:** [Greenhouse gas emissions](https://ec.europa.eu/eurostat/data/database#Flags)  
- **My Tableau Public Dashboard:** [Greenhouse Emissions](https://public.tableau.com/app/profile/anastasiia.rykalova/viz/EUGreenhouseGasEmissionsDashboard/Dashboard1)  
- **My GitHub Repository:** [Repository](https://github.com/a-ryka/greenhouse_emissions)  
- **Mermaidchart:** [Database Diagram](https://www.mermaidchart.com/app/projects/ab37573f-f236-4a92-a05e-685ff634e6da/diagrams/49196a84-fea2-497d-b760-4ff6ab5f59aa/version/v0.1/edit)  

---

## Key Insights 

**Long-term Trend**
- Total GHG emissions in the EU27 show a steady decline since 1990, reflecting climate policies, structural economic changes, and improved energy efficiency.
- Despite progress, recent years highlight volatility due to external shocks (e.g., COVID-19, energy crisis of 2022).

**Sectoral Contributions**
- Energy supply and Manufacturing remain the largest sources of emissions, together accounting for more than half of total EU27 GHG emissions.
- Agriculture and Transport are persistent contributors with relatively stable shares, indicating slower decarbonization progress.
- Household emissions are declining but remain significant.

**Cross-country Comparisons**
- Countries like Germany (DE) show substantial reductions compared to 1990, but remain among the largest emitters in absolute terms.
- Austria (AT) and Poland (PL) illustrate contrasting trajectories: Austria’s emissions intensity decreased more steadily, while Poland’s reductions are limited due to coal dependency.
- Per capita emissions reveal strong disparities, with smaller states and carbon-intensive economies often in the Top 10 emitters per person.

**Intensity & Efficiency**
- Emissions per GDP (G_GDP) have decreased, signaling relative decoupling of economic growth and emissions.
- However, emissions per km (G_KM) still vary widely between countries, highlighting uneven transport sector efficiency.
- Heatmaps show some convergence across EU states, but persistent outliers remain.

**Quarterly & YoY Dynamics**
- Average quarterly analysis reveals higher emissions in Q1 and Q4, suggesting seasonal peaks linked to heating demand.
- YoY change analysis shows sharp drops during 2009 (financial crisis) and 2020 (COVID-19 lockdowns), and a rebound afterward.
- 2022 stands out as a policy-driven inflection year, where high energy prices and EU measures significantly shaped emissions trajectories.

---

## Why This Project Is Useful

It demonstrates a complete and reproducible workflow for analyzing greenhouse gas emissions in the EU27, starting from raw CSV data, loading it into a PostgreSQL database, building SQL views, and finally applying Python (pandas, seaborn, matplotlib) for analysis and visualization. It provides not only a technical template for similar environmental or economic data projects but also delivers policy-relevant insights by showing long-term emission trends, sectoral structures, cross-country differences, and the impact of external shocks such as the financial crisis, COVID-19, and the 2022 energy crisis.