# U.S. Unemployment Trends (2015–2024)

## Business Question
How did unemployment trends vary across U.S. states before, during, and after the COVID-19 economic shock—and what patterns can inform workforce planning and policy decisions?

## Summary of Findings
- Unemployment rates spiked nationally in 2020, but recovery timelines differed dramatically by state.
- States with higher pre-pandemic unemployment tended to recover more slowly post-2020.
- Several states consistently ranked above the national average across the decade, indicating structural labor market challenges.
- Puerto Rico followed a distinct unemployment trajectory, suggesting different economic drivers compared to U.S. states.

## Why This Matters
Understanding unemployment trends at the state level helps:
- Policymakers allocate workforce development resources
- Businesses assess regional labor market risk
- Analysts identify long-term structural employment challenges beyond short-term shocks

---

## Project Objectives
- Build a clean, analysis-ready unemployment dataset from raw BLS LAUS data
- Quantify state-level unemployment trends and year-over-year changes
- Identify states with persistent unemployment risk across economic cycles
- Compare pre- and post-COVID labor market behavior
- Communicate findings through an interactive Tableau dashboard for non-technical stakeholders

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
- The COVID-19 shock caused a uniform national spike in unemployment in 2020, but recovery trajectories varied by state, with some states returning to pre-pandemic levels by 2022 while others lagged significantly.
- States with historically higher unemployment rates prior to 2020 were more likely to experience prolonged recovery periods, suggesting structural labor market vulnerabilities.
- Western and Southern states showed greater volatility in unemployment rates compared to the Midwest.
- Puerto Rico exhibited consistently higher unemployment and a slower recovery, indicating economic dynamics distinct from U.S. states.

---

## How This Analysis Could Be Used
- Support workforce planning and economic policy discussions
- Identify states at higher risk during economic downturns
- Inform regional business expansion or hiring strategies
- Serve as a reusable SQL pipeline for future labor market analyses

---

## Author
**Muskan Basnet**  
B.S. Computer Science  
Data Analytics & Visualization Portfolio Project

