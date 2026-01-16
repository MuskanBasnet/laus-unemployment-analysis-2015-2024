-- Exporting laus_unemployment_2015_2024 to csv to visualize with Tableau
USE laus_analysis;

SELECT
  state,
  year,
  month,
  unemployment_rate
FROM laus_unemployment_2015_2024
ORDER BY state, year, month;

-- After running query, export to CSV file
-- Saved as laus_unemployment_2015_2024.csv in data folder