/*
01_laus_data_cleaning.sql

Purpose:
- Inspect imported LAUS data
- Create staging tables
- Enforce schema and data types
- Filter to monthly unemployment rate series only

Tables created:
- laus_raw
- laus_unemployment_raw
*/

-- Creating raw staging table
USE laus_analysis;

DROP TABLE IF EXISTS laus_raw;

CREATE TABLE laus_raw (
    series_id VARCHAR(30),
    year INT,
    period VARCHAR(5),
    value DECIMAL(6,2),
    footnote_codes VARCHAR(10)
);

-- Inspect raw data structure
-- 1) Confirm table exists and has rows
SELECT COUNT(*) AS row_count
FROM laus_allstates_s;
-- expected: 185376
-- actual: 185736

-- 2) See column names + types
DESCRIBE laus_allstates_s;
-- expected: series_id/text , year/int , period/text , value/double , footnote_codes/text
-- actual: series_id/text , year/int , period/text , value/double , footnote_codes/text

-- 3) Check first 20 rows
SELECT * FROM laus_allstates_s
LIMIT 20;

-- 4) Check distinct period values
SELECT period, COUNT(*) AS n
FROM laus_allstates_s
GROUP BY period
ORDER BY period;

-- 5) Check years
SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM laus_allstates_s;
-- expected: min_year = 1976 max_year = 2025
-- actual: min_year = 1976 max_year = 2025


-- Reset staging table
ALTER TABLE laus_raw
MODIFY COLUMN value DECIMAL(12,2);

TRUNCATE TABLE laus_raw;

-- Insert monthly data with clean types
INSERT INTO laus_raw (series_id, year, period, value, footnote_codes)
SELECT
    series_id,
    year,
    period,
    CAST(value as DECIMAL(12,2)) AS value,
    footnote_codes
FROM laus_allstates_s
WHERE period LIKE 'M%';

-- QUICK CHECK
SELECT COUNT(*) AS n FROM laus_raw;
SELECT MIN(value) as min_v, MAX(value) AS max_v FROM laus_raw;

-- Need to find series_id for unemployment rate
-- Pull measure code from end of series_id and count
SELECT
  RIGHT(series_id, 2) AS measure_code,
  COUNT(*) AS n,
  MIN(value) AS min_value,
  MAX(value) AS max_value
FROM laus_raw
GROUP BY RIGHT(series_id, 2)
ORDER BY n DESC;

-- Need to strip whitespace
SELECT
  RIGHT(TRIM(series_id), 2) AS measure_code,
  COUNT(*) AS n,
  MIN(value) AS min_value,
  MAX(value) AS max_value
FROM laus_raw
GROUP BY RIGHT(TRIM(series_id), 2)
ORDER BY n DESC;

-- Isolating unemployment rate rows
DROP TABLE IF EXISTS laus_unemployment_raw;

CREATE TABLE laus_unemployment_raw AS
SELECT
    TRIM(series_id) AS series_id,
    year,
    period,
    value AS unemployment_rate
FROM laus_raw
WHERE RIGHT(TRIM(series_id), 2) = '03';

-- QUICK CHECK
SELECT COUNT(*) FROM laus_unemployment_raw;
SELECT MIN(unemployment_rate), MAX(unemployment_rate) FROM laus_unemployment_raw;
SELECT DISTINCT period FROM laus_unemployment_raw ORDER BY period;
