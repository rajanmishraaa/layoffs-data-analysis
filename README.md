# Layoffs SQL Project

This project analyzes and cleans tech layoff data using **MySQL**. It includes SQL scripts for cleaning the raw data and performing exploratory data analysis (EDA).

##  Project Structure

- **/data**
  - `layoffs.csv`: Raw dataset  
  - `layoffs_cleaned.csv`: Cleaned version of the dataset after SQL transformations

- **/sql**
  - `layoffs_cleaning.sql`: SQL code for data cleaning  
  - `layoffs_exploratory_analysis.sql`: SQL code for exploratory analysis

##  Skills Used

- CTEs and Window Functions (`ROW_NUMBER()`)
- String Cleaning (`TRIM`)
- Date Formatting (`STR_TO_DATE`)
- NULL Handling and Filtering
- Aggregations and Grouping
- Basic Joins and Subqueries
- Data Deduplication and Standardization

##  Note on NULL Values

You’ll find a large number of `NULL` values in the `total_laid_off` and `percentage_laid_off` columns.  
This is because there is **no available data on the total number of employees per company**, making it impossible to accurately calculate or verify layoff percentages for many entries.  
These were intentionally left as NULL to avoid incorrect assumptions or fake data.

##  Data Cleaning Summary

- Trimmed and standardized values across key columns (`country`, `industry`, `date`)
- Removed trailing characters (e.g., "United States.")
- Standardized inconsistent labels (e.g., grouped all crypto-related values under "Crypto")
- Removed duplicate records using window functions
- Converted string dates into proper `DATE` format
- Filled missing `industry` values by referencing company data
- Deleted rows with no meaningful layoff information

##  Exploratory Data Analysis (EDA)

- Identified top companies and countries with the highest number of layoffs  
- Tracked layoff trends over time (monthly breakdown)  
- Analyzed total vs. percentage of employees laid off  
- Studied layoffs by company stage and industry  
- Compared layoff figures against funding raised  
- Calculated averages and standard deviations to find extreme cases

---

