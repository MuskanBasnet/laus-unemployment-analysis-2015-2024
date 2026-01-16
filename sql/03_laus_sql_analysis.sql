/*
03_laus_sql_analysis.sql

Purpose:
- Answer analytical questions using cleaned LAUS unemployment data (2015–2024)

Data source:
- laus_unemployment_2015_2024
*/

/* -------------------------------------------------
   Q1: Average unemployment rate by state (2015–2024)
--------------------------------------------------- */

SELECT
  state,
  ROUND(AVG(unemployment_rate), 2) AS avg_unemployment_rate_2015_2024
FROM laus_unemployment_2015_2024
GROUP BY state
ORDER BY avg_unemployment_rate_2015_2024 DESC;

/* -------------------------------------------------
   Q2a: Yearly average unemployment rate by state
--------------------------------------------------- */

SELECT
  state,
  year,
  ROUND(AVG(unemployment_rate), 2) AS avg_unemployment_rate
FROM laus_unemployment_2015_2024
GROUP BY state, year
ORDER BY state, year;

/* -------------------------------------------------
   Q2b: Year-over-year change in unemployment rate
--------------------------------------------------- */

SELECT
  curr.state,
  curr.year,
  ROUND(curr.avg_unemployment_rate - prev.avg_unemployment_rate, 2)
    AS yoy_change
FROM (
    SELECT state, year, AVG(unemployment_rate) AS avg_unemployment_rate
    FROM laus_unemployment_2015_2024
    GROUP BY state, year
) curr
JOIN (
    SELECT state, year, AVG(unemployment_rate) AS avg_unemployment_rate
    FROM laus_unemployment_2015_2024
    GROUP BY state, year
) prev
  ON curr.state = prev.state
 AND curr.year = prev.year + 1
ORDER BY yoy_change DESC;

/* -------------------------------------------------
   Q3: Rank states by average unemployment rate (per year)
--------------------------------------------------- */

SELECT
  state,
  year,
  ROUND(avg_unemployment_rate, 2) AS avg_unemployment_rate,
  RANK() OVER (
    PARTITION BY year
    ORDER BY avg_unemployment_rate DESC
  ) AS unemployment_rank
FROM (
  SELECT
    state,
    year,
    AVG(unemployment_rate) AS avg_unemployment_rate
  FROM laus_unemployment_2015_2024
  GROUP BY state, year
) yearly_avg
ORDER BY year, unemployment_rank;

/* -------------------------------------------------
   Q4: Peak unemployment month per state (2015–2024)
--------------------------------------------------- */

SELECT
  state,
  year,
  month,
  unemployment_rate
FROM (
  SELECT
    state,
    year,
    month,
    unemployment_rate,
    RANK() OVER (
      PARTITION BY state
      ORDER BY unemployment_rate DESC
    ) AS rnk
  FROM laus_unemployment_2015_2024
) ranked
WHERE rnk = 1
ORDER BY unemployment_rate DESC;

/* -------------------------------------------------
   Q5: Pre- vs Post-spike unemployment comparison
   Pre-spike: 2015–2019
   Post-spike: 2021–2024
--------------------------------------------------- */

SELECT
  state,
  period_label,
  ROUND(AVG(unemployment_rate), 2) AS avg_unemployment_rate
FROM (
  SELECT
    state,
    unemployment_rate,
    CASE
      WHEN year BETWEEN 2015 AND 2019 THEN 'Pre-spike (2015–2019)'
      WHEN year BETWEEN 2021 AND 2024 THEN 'Post-spike (2021–2024)'
    END AS period_label
  FROM laus_unemployment_2015_2024
  WHERE year != 2020
) labeled
GROUP BY state, period_label
ORDER BY state, period_label;
