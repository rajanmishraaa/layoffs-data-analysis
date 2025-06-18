#--Exploratory Data Analysis--

select *
from layoffs_cleaned;																	

SELECT COUNT(*) AS total_rows FROM layoffs_cleaned;
DESCRIBE layoffs_cleaned;

SELECT 
  SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END) AS null_company,
  SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS null_location,
  SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS null_industry,
  SUM(CASE WHEN total_laid_off IS NULL THEN 1 ELSE 0 END) AS null_total_laid_off,
  SUM(CASE WHEN percentage_laid_off IS NULL THEN 1 ELSE 0 END) AS null_percentage_laid_off,
  SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
  SUM(CASE WHEN stage IS NULL THEN 1 ELSE 0 END) AS null_stage,
  SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_country,
  SUM(CASE WHEN funds_raised_millions IS NULL THEN 1 ELSE 0 END) AS null_funding
FROM layoffs_cleaned;


SELECT 
  MIN(total_laid_off) AS min_layoffs,
  MAX(total_laid_off) AS max_layoffs,
  AVG(total_laid_off) AS avg_layoffs
FROM layoffs_cleaned;

select company , total_laid_off 
from layoffs_cleaned 
where company = 'amazon';

select company , total_laid_off 
from layoffs_cleaned 
where company = 'Google';

SELECT 
  MIN(percentage_laid_off) AS min_percent,
  MAX(percentage_laid_off) AS max_percent,
  AVG(percentage_laid_off)*100 AS avg_percent,
  STDDEV(percentage_laid_off)*100 AS std_layoffs
FROM layoffs_cleaned;


SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY country
ORDER BY total_laid_off DESC;


SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 5;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY total_laid_off ASC
LIMIT 5;


SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY industry
ORDER BY total_laid_off DESC;


SELECT DATE_FORMAT(date, '%Y-%m') AS `month`, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY `month`
ORDER BY `month`;


SELECT 
    stage, SUM(total_laid_off) AS total_laid_off
FROM
    layoffs_cleaned
GROUP BY stage
ORDER BY total_laid_off DESC;


SELECT company, total_laid_off, funds_raised_millions
FROM layoffs_cleaned
WHERE funds_raised_millions IS NOT NULL
ORDER BY total_laid_off DESC
LIMIT 20;






