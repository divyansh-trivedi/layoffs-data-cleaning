-- Data Cleaning Project

USE world_layoffs;


SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardrize the data
-- 3. Null Values or blank values
-- 4. Remove any columns

-- Creating new database so that we have a backup

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;
-- 1. Remove Duplicates


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company , location , industry, total_laid_off , percentage_laid_off, `date`, stage , country, funds_raised_millions)
AS row_num
FROM layoffs_staging
)
-- Gathering duplicate
SELECT * 
FROM duplicate_cte

; 
/*
------- this will not work
because cte is not updatable but only modifyable

ans here there is no unique id col , if it would have been there then we wuld have directly done this
WITH duplicate_cte AS
(
  SELECT *,
    ROW_NUMBER() OVER(
       PARTITION BY company , location , industry, total_laid_off , percentage_laid_off, `date`, stage , country, funds_raised_millions
    ) AS row_num
  FROM layoffs_staging
)
DELETE FROM layoffs_staging
WHERE id IN (SELECT id FROM duplicate_cte WHERE row_num > 1);


-- so make another table and remove records that are duplicate
 */
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
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 SELECT * 
 FROM layoffs_staging2;
 
 INSERT INTO layoffs_staging2
	 SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY company , location , industry, total_laid_off , percentage_laid_off, `date`, stage , country, funds_raised_millions)
	AS row_num
	FROM layoffs_staging;
    
 DELETE 
 FROM layoffs_staging2
 WHERE row_num > 1;
;

SELECT * 
 FROM layoffs_staging2;
 
 
 SET SQL_SAFE_UPDATES = 0;

 -- Duplicate Removed
 USE   world_layoffs;
 SELECT * 
 FROM layoffs_staging2;
 
 -- 2. Standardrize the data
 SELECT DISTINCT INDUSTRY
 FROM layoffs_staging2
 ORDER BY 1;
 
 SELECT industry, company ,TRIM(company)
 FROM layoffs_staging2
 WHERE industry LIKE 'Crypto%';
 
 UPDATE layoffs_staging2
 SET industry = 'Crypto'
 WHERE industry LIKE 'Crypto%'; -- cryotocurrency and crypto is same chnage it to crypto
 
 SELECT DISTINCT country
 FROM layoffs_staging2
 ORDER BY 1; -- removing -> united states. as correct is united states , other is dupilcate
 
 UPDATE layoffs_staging2
 SET country = TRIM(TRAILING '.' FROM country);
 
 SELECT DISTINCT country
 FROM layoffs_staging2
 ORDER BY 1; -- removed
 
 SELECT `date` 
 FROM layoffs_staging2; -- correct the format str to date
 
 SELECT `date` ,
 STR_TO_DATE(`date`,'%m/%d/%Y')
 FROM layoffs_staging2;  -- Corrected format -> 10/12/2022 to 	2022-10-12
 
 ALTER TABLE layoffs_staging2
 MODIFY COLUMN `date` DATE;
 
 -- 3. Null Values or blank values
 
 SELECT * 
 FROM layoffs_staging2
 WHERE total_laid_off IS NULL 
 AND
 percentage_laid_off IS NULL
 ; 
 
 SELECT industry 
 FROM layoffs_staging2 
 WHERE industry IS NULL 
 OR industry = ''
 ;
 SELECT * 
 FROM layoffs_staging2 
 WHERE company = 'Airbnb';
 
 UPDATE layoffs_staging2 
 SET industry = NULL
 WHERE industry = '';
 
 SELECT *
 FROM layoffs_staging2 t1
 JOIN layoffs_staging2 t2
	 ON t1.company = t2.company 
	 AND t1.location = t2.location
WHERE (t1.industry IS NULL )
AND (t2.industry IS NOT NULL)     
;
UPDATE layoffs_staging2 t1
 JOIN layoffs_staging2 t2
	 ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL )
AND (t2.industry IS NOT NULL);
  
SELECT * 
FROM layoffs_staging2;

---- 4. Remove any columns
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;

-- Cleaned Data by doing all 4 things -;

-- 1. Remove Duplicates
-- 2. Standardrize the data
-- 3. Null Values or blank values
-- 4. Remove any columns
