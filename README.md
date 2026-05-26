# Layoffs SQL & Power BI Project

This project analyzes and visualizes global tech layoff data from 2020–2023 using MySQL and Power BI.  
It covers the complete analyst workflow: data cleaning, exploratory data analysis (EDA), and interactive dashboard creation.

---

# Project Structure

```bash
/data
│
├── layoffs.csv
└── layoffs_cleaned.csv

/sql_queries
│
├── layoffs_cleaning.sql
└── layoffs_exploratory_analysis.sql

/dashboards
│
├── layoffs_dashboard.pbix
├── overview_page.png
└── deep_dive_page.png
```

---

# Tools & Technologies

- MySQL
- Power BI
- SQL
- DAX
- Power Query

---

# Skills Demonstrated

## SQL
- CTEs and Window Functions (`ROW_NUMBER()`)
- Data Deduplication
- Aggregations and Grouping
- Joins and Subqueries
- NULL Handling and Filtering
- String Cleaning (`TRIM`)
- Date Formatting (`STR_TO_DATE`)
- Data Standardization

## Power BI
- Interactive Dashboard Design
- KPI Cards
- Scatter Plots
- Time-Series Visualization
- Slicers and Cross-Filtering
- Data Modeling and Relationships
- DAX Measures
- Dashboard Storytelling

---

# Data Cleaning Summary

The raw dataset contained inconsistent formatting, duplicate records, missing values, and non-standardized labels.

Cleaning steps included:

- Trimmed and standardized values across key columns
- Removed trailing characters such as `"United States."`
- Standardized inconsistent labels (e.g., grouped all crypto-related entries under `"Crypto"`)
- Removed duplicate records using window functions
- Converted string dates into proper `DATE` format
- Filled missing industry values using existing company records
- Removed rows with no meaningful layoff information

---

# Exploratory Data Analysis

The analysis focused on identifying trends and patterns in global tech layoffs.

Key areas explored:

- Companies with the highest layoffs
- Countries most affected by layoffs
- Industry-wise layoff trends
- Layoffs by funding stage
- Monthly and yearly layoff trends
- Relationship between funding raised and layoffs
- Extreme layoff cases using averages and standard deviations

---

# Power BI Dashboard

The Power BI dashboard was built using the cleaned dataset and includes:

## Overview Page
- Total layoffs KPI
- Companies affected KPI
- Countries affected KPI
- Hardest hit industry KPI
- Layoffs over time
- Layoffs by country
- Layoffs by industry

## Deep Dive Page
- Top companies by layoffs
- Layoffs by funding stage
- Yearly layoff comparison
- Funding raised vs layoffs scatter plot
- Interactive slicers for filtering

---

# Key Insights

- 2022 experienced the largest spike in layoffs
- The United States accounted for the highest number of layoffs
- Late-stage and post-IPO companies were heavily impacted
- High funding levels did not necessarily prevent layoffs
- Certain industries experienced significantly higher workforce reductions

---

# Note on NULL Values

A large number of `NULL` values exist in the `total_laid_off` and `percentage_laid_off` columns.

This is because complete employee count data was unavailable for many companies, making accurate layoff percentage calculations impossible.

These values were intentionally preserved as `NULL` to avoid introducing misleading or fabricated data.

---

# Dataset

Dataset inspired by the tech layoffs dataset commonly used in Alex Freberg’s Data Analyst Bootcamp and sourced from layoff tracking data.
