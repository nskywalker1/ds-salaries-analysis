SELECT TOP 5
	*
FROM ds_salaries

SELECT 
	DISTINCT COUNT(*) AS unique_rows,
	COUNT(*)  AS total_rows
FROM ds_salaries

SELECT DISTINCT experience_level FROM ds_salaries
SELECT DISTINCT job_title FROM ds_salaries
SELECT DISTINCT company_location FROM ds_salaries
SELECT DISTINCT company_size FROM ds_salaries

SELECT 
	MAX(work_year) AS max_work_year, 
	MIN(work_year) AS min_work_year
FROM ds_salaries

/* OBJECTIVE: Analyze how experience levels (Entry, Mid, Senior, Executive) affect compensation.
METRICS: 
 - Average Salary by Seniority
 - Salary Range (Min/Max) per Experience Level
 - Distribution of Staff across seniority levels
*/
SELECT
	experience_level,
	COUNT(*) AS total_staff,
	AVG(salary_in_usd) AS avg_salary_usd,
	MIN(salary_in_usd) AS min_salary,
	MAX(salary_in_usd) AS max_salary
FROM ds_salaries
GROUP BY experience_level
ORDER BY avg_salary_usd DESC

/* OBJECTIVE: Rank job titles by average salary to identify top-paying roles.
METRICS: 
 - Average, Minimum, and Maximum Salary in USD
 - Total Staff (Filtered for statistical significance, min 5 observations)
 - Salary Rank (Using DENSE_RANK)
*/
WITH avg_salaries_job AS (
SELECT
	job_title,
	COUNT(*) AS total_staff,
	AVG(salary_in_usd) AS avg_salary_usd,
	MIN(salary_in_usd) AS min_salary,
	MAX(salary_in_usd) AS max_salary
FROM ds_salaries
GROUP BY job_title
HAVING COUNT(*) >= 5
)
SELECT 
	job_title,
	avg_salary_usd,
	min_salary,
	max_salary,
	DENSE_RANK() OVER(ORDER BY avg_salary_usd DESC) AS rank_column
FROM avg_salaries_job

/* OBJECTIVE: Analyze annual salary trends for Data Science roles.
METRICS: 
 - Total Staff (Sample Size per year)
 - Average Salary in USD
 - Absolute Salary Difference (Salary Delta)
 - Year-over-Year (YoY) Growth %
*/
WITH avg_salaries_year AS (
SELECT
	work_year,
	AVG(salary_in_usd) AS avg_salary_usd,
	COUNT(*) AS total_staff
FROM ds_salaries
GROUP BY work_year
)
SELECT 
	work_year,
	avg_salary_usd,
	salary_diff,
	total_staff,
	CASE WHEN salary_diff IS NULL THEN '0 %'
		 ELSE CONCAT(CAST(salary_diff * 100.0 / LAG(avg_salary_usd) OVER (ORDER BY work_year) AS DECIMAL(10,2)), ' %')  
	END AS yoy_growth_pct
FROM
(
SELECT
	work_year,
	avg_salary_usd,
	total_staff,
	avg_salary_usd - LAG(avg_salary_usd) OVER (ORDER BY work_year) AS salary_diff
FROM avg_salaries_year
)t

/* OBJECTIVE: Compare compensation across different work settings (On-site, Hybrid, Remote).
METRICS: 
 - Average Salary in USD per work format
 - Distribution of staff (Total Staff) to verify sample size
 - Identifying the "Remote Premium" in the Data Science market
*/
SELECT 
	CASE 
		WHEN remote_ratio = 50 THEN 'Hybrid'
		WHEN remote_ratio = 100 THEN 'Remote'
		ELSE 'On-site'
	END work_format,
	AVG(salary_in_usd) AS avg_salary_in_usd,
	COUNT(*) AS total_staff
FROM ds_salaries
GROUP BY remote_ratio
ORDER BY avg_salary_in_usd DESC


/* OBJECTIVE: Classify annual hiring dynamics into growth or decline segments.
METRICS: 
 - Current and Previous Year Headcount
 - Absolute Change (Staff Diff)
 - Market Trend Label (Growth, Stable, Decline)
*/
WITH staff_stats AS ( SELECT
	work_year,
	experience_level,
	COUNT(*) AS total_staff
FROM ds_salaries
GROUP BY experience_level, work_year
)

SELECT
	work_year,
	experience_level,
	total_staff,
	prev_year_staff,
	staff_diff,
	CASE 
		WHEN staff_diff IS NULL THEN 'New Baseline'
		WHEN staff_diff = 0 THEN 'Stable'
		WHEN staff_diff < 0 THEN 'Decline'
		ELSE 'Growth'
	END AS staff_diff_segment
FROM
(
SELECT
	work_year,
	experience_level,
	total_staff,
	LAG(total_staff) OVER(PARTITION BY experience_level ORDER BY work_year) AS prev_year_staff,
	total_staff - LAG(total_staff) OVER (PARTITION BY experience_level ORDER BY work_year) AS staff_diff
FROM staff_stats
)t
ORDER BY work_year, experience_level DESC


