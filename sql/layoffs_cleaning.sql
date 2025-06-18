#--- DATA CLEANING---


SELECT * FROM world_layoffs.layoffs;


#REMOVING DUPLICATES


create table layoffs_staging
like  layoffs;


select * 
	from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

select distinct trim(country)  
 from layoffs_staging;
 
 select country from layoffs_staging
 where country like '%.%';

UPDATE layoffs_staging
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE '%United States.%';


select
 trim(country) as country, trim(company) as company, trim(location) as location, 
trim(industry) as industry, trim(total_laid_off) as total_laid_off,
 trim(percentage_laid_off) as percentage_laid_off,
 trim(`date`) as `date`, trim(stage) as stage , trim(funds_raised_millions) as funds_raised_millions
 from layoffs_staging; 
 
 
 

    SELECT *,
     ROW_NUMBER() OVER(
        PARTITION BY company, industry, 
        total_laid_off, percentage_laid_off, `date`) as row_num
        from layoffs_staging;
        
	with duplicate_cte as 
    (
        SELECT *,
     ROW_NUMBER() OVER(
        PARTITION BY company, industry, 
        total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
        from layoffs_staging
    )
select * 
from duplicate_cte
where row_num > 1;

select * from layoffs_staging order by company asc;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

insert into layoffs_staging2
SELECT *,
     ROW_NUMBER() OVER(
        PARTITION BY company, industry, 
        total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
        from layoffs_staging;
        
  delete from layoffs_staging2
    where row_num > 1 ;
    
select * from layoffs_staging2;


#STANDERDIZING DATA

select
 company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num ,trim(country) as country, trim(company) as company, trim(location) as location, 
trim(industry) as industry, trim(total_laid_off) as total_laid_off,
 trim(percentage_laid_off) as percentage_laid_off,
 trim(`date`) as `date`, trim(stage) as stage , trim(funds_raised_millions) as funds_raised_millions
 from layoffs_staging2; 
 

update layoffs_staging2
set company = trim(company);
 
 select distinct industry 
 from layoffs_staging2
 order by 1;
 
 
 select * 
 from layoffs_staging2
 where industry like 'Crypto%';
 
 update layoffs_staging2
 set industry = 'Crypto'
 where industry like 'Crypto%';
 
 
 select * 
 from layoffs_staging2;
 
 UPDATE layoffs_staging2 
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
WHERE `date` LIKE '%/%/%';


update layoffs_staging2 
set `date` = str_to_date(`date`, '%m/%d/%Y');


select `date` from layoffs_staging2;


alter table layoffs_staging2
modify column `date` date;

#-- 3. Null Values or blank values

select * from layoffs_staging2;

select
	company, location, industry
from layoffs_staging2
where industry is null or industry like '';


select
	company, location, industry
from layoffs_staging2
where company = 'airbnb';


select
	company, location, industry
from layoffs_staging2
where company = 'carvana';


select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or  t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 
set industry = null
where industry = ''; 

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select * from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;


#-- 4. Remove Any Columns


alter table layoffs_staging2
 drop column row_num;

select * from layoffs_staging2;


