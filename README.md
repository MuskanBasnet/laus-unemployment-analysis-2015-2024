# U.S. Unemployment Trends (2015–2024)

## Overview
This project analyzes U.S. state-level unemployment trends from **2015 to 2024** using data from the **Bureau of Labor Statistics (LAUS)**. The goal is to explore how unemployment rates vary across states over time, identify peak unemployment periods, and examine the impact of the COVID-19 economic shock.

The project emphasizes a structured **SQL data pipeline**, analytical querying, and **interactive visualization** using Tableau.

---

## Objectives
- Clean and transform raw LAUS unemployment data
- Analyze unemployment trends across states and over time
- Identify year-over-year changes and peak unemployment periods
- Compare pre- and post-COVID unemployment patterns
- Communicate insights through an interactive Tableau dashboard

---

## Tools & Technologies
- **MySQL** – data cleaning, transformation, and analysis  
- **SQL** – aggregation, filtering, window functions  
- **Tableau Public** – interactive visualizations and dashboard  
- **GitHub** – version control and documentation  

---

## Data Source
- **Bureau of Labor Statistics (BLS) – Local Area Unemployment Statistics (LAUS)**
- Monthly unemployment rates for all U.S. states, Washington D.C., and Puerto Rico
- Original dataset spans 1976–2024; analysis focuses on **2015–2024** to reflect modern labor market trends


---

## Data Pipeline Summary
1. **Raw Import**
   - Imported LAUS data into MySQL without modification.

2. **Cleaning & Staging**
   - Filtered to monthly observations only.
   - Isolated unemployment rate series.
   - Standardized schemas and data types.

3. **Transformation**
   - Extracted state identifiers and mapped to abbreviations.
   - Converted period codes to numeric months.
   - Created an analysis-ready dataset.

4. **Analysis Scope**
   - Filtered data to **2015–2024** for focused analysis.

---

## SQL Analysis Highlights
The following analyses were performed using SQL:
- Average unemployment rate by state
- Year-over-year unemployment changes
- Ranking states by unemployment rate
- Identification of peak unemployment months
- Comparison of pre-COVID (2015–2019) vs post-COVID (2021–2024) periods

All queries are documented in the `sql/` directory.

---

## Tableau Dashboard
An interactive Tableau dashboard was created to visualize:
- National unemployment trends over time
- State-level unemployment comparisons
- State unemployment rankings by year
- Peak unemployment rates and timing by state

[ **Tableau Public Dashboard**  ](https://public.tableau.com/views/U_S_UnemploymentTrends2015-2024/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


---

## Key Insights
- Unemployment rates across all states spiked sharply in **2020**, corresponding to the COVID-19 pandemic.
- Recovery patterns varied significantly by state.
- Some states consistently experienced higher unemployment rates across the decade.
- Puerto Rico exhibited distinct unemployment dynamics compared to U.S. states.



---

## Author
**Muskan Basnet**  
B.S. Computer Science  
Data Analytics & Visualization Portfolio Project

