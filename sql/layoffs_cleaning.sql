
#--Data Cleaning--

-- creating staging table to work with
CREATE TABLE layoffs_staging LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- fixing country name issues
UPDATE layoffs_staging
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE '%United States.%';

-- checking and trimming key columns
SELECT
    TRIM(country) AS country,
    TRIM(company) AS company,
    TRIM(location) AS location,
    TRIM(industry) AS industry,
    TRIM(total_laid_off) AS total_laid_off,
    TRIM(percentage_laid_off) AS percentage_laid_off,
    TRIM(`date`) AS `date`,
    TRIM(stage) AS stage,
    TRIM(funds_raised_millions) AS funds_raised_millions
FROM layoffs_staging;

-- checking duplicates
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, industry, total_laid_off,
                            percentage_laid_off, `date`, stage,
                            country, funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- creating second staging table
CREATE TABLE layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT,
  row_num INT
);

-- insert into new table with row_num
INSERT INTO layoffs_staging2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, industry, total_laid_off,
                        percentage_laid_off, `date`, stage,
                        country, funds_raised_millions
       ) AS row_num
FROM layoffs_staging;

-- remove duplicates
DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- fixing inconsistent industry values
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- clean date format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
WHERE `date` LIKE '%/%/%';

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- fix missing industries using matching companies
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- drop rows with no layoff info
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- removing extra columns
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



