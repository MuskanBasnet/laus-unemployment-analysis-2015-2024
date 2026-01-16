/*
02_laus_data_transformation.sql

Purpose:
- Decode series_id into geographic identifiers
- Convert period codes into numeric months
- Join to state FIPS lookup
- Produce analysis-ready unemployment dataset

Output table:
- laus_unemployment_clean
*/

-- Creating derived table with extracted FIPS
USE laus_analysis;

DROP TABLE IF EXISTS laus_unemployment_with_fips;

CREATE TABLE laus_unemployment_with_fips AS
SELECT
    series_id,
    SUBSTRING(series_id, 6, 2) AS state_fips,
    year,
    period,
    unemployment_rate
FROM laus_unemployment_raw;

-- QUICK CHECK
SELECT
  state_fips,
  COUNT(*) AS n
FROM laus_unemployment_with_fips
GROUP BY state_fips
ORDER BY state_fips;

-- Creating an abbreviation lookup table
DROP TABLE IF EXISTS state_abbrev_lookup;

CREATE TABLE state_abbrev_lookup (
    fips CHAR(2) PRIMARY KEY,
    abbrev CHAR(2) NOT NULL
);

-- Inserting abbreviations
INSERT INTO state_abbrev_lookup (fips, abbrev) VALUES
('01','AL'),('02','AK'),('04','AZ'),('05','AR'),('06','CA'),('08','CO'),('09','CT'),('10','DE'),
('11','DC'),('12','FL'),('13','GA'),('15','HI'),('16','ID'),('17','IL'),('18','IN'),('19','IA'),
('20','KS'),('21','KY'),('22','LA'),('23','ME'),('24','MD'),('25','MA'),('26','MI'),('27','MN'),
('28','MS'),('29','MO'),('30','MT'),('31','NE'),('32','NV'),('33','NH'),('34','NJ'),('35','NM'),
('36','NY'),('37','NC'),('38','ND'),('39','OH'),('40','OK'),('41','OR'),('42','PA'),('44','RI'),
('45','SC'),('46','SD'),('47','TN'),('48','TX'),('49','UT'),('50','VT'),('51','VA'),('53','WA'),
('54','WV'),('55','WI'),('56','WY'),('72','PR');

-- Joining to unemployment table
DROP TABLE IF EXISTS laus_unemployment_with_state;

CREATE TABLE laus_unemployment_with_state AS
SELECT
    u.series_id,
    u.state_fips,
    a.abbrev AS state,
    u.year,
    u.period,
    u.unemployment_rate
FROM laus_unemployment_with_fips u
JOIN state_abbrev_lookup a 
    ON u.state_fips = a.fips;

-- QUICK CHECK
SELECT state, COUNT(*) AS n
FROM laus_unemployment_with_state
GROUP BY state
ORDER BY state;

-- Creating final clean table
DROP TABLE IF EXISTS laus_unemployment_clean;

CREATE TABLE laus_unemployment_clean AS
SELECT
    state,
    year,
    CAST(SUBSTRING(period, 2, 2) AS UNSIGNED) AS month,
    unemployment_rate
FROM laus_unemployment_with_state;

-- QUICK CHECK
SELECT MIN(month), MAX(month) FROM laus_unemployment_clean;
-- expected range: 1-12
-- actual range: 1-12

SELECT *
FROM laus_unemployment_clean
ORDER BY state, year, month
LIMIT 20;

-- Creating 2015-2024 subset (10 year frame)
DROP TABLE IF EXISTS laus_unemployment_2015_2024;

CREATE TABLE laus_unemployment_2015_2024 AS
SELECT *
FROM laus_unemployment_clean
WHERE year BETWEEN 2015 AND 2024;

-- QUICK CHECK
SELECT MIN(year), MAX(year)
FROM laus_unemployment_2015_2024;
-- expected 2015-2024
-- actual 2015-2024

SELECT COUNT(*) AS n
FROM laus_unemployment_2015_2024;

-- Adding indexes
-- Index for time-based filtering
CREATE INDEX idx_laus_year
ON laus_unemployment_2015_2024 (year);

-- Index for state comparisons
CREATE INDEX idx_laus_state
ON laus_unemployment_2015_2024 (state);

-- Composite index for time-series analysis per state
CREATE INDEX idx_laus_state_year_month
ON laus_unemployment_2015_2024 (state, year, month);
