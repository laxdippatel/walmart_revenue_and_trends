select *from walmart;

--drop the table 
drop table walmart;
--- count tabledata
select count(*) from walmart;
---- how many payment methods
Select payment_method,
	   COUNT(*)
from walmart
GROUP BY payment_method;
--- count the branch
select count(DISTINCT branch)branch
from walmart;
--- minimum quantity
select MIN(quantity) from walmart;
-- business problems
-- Q-1 Find different payment methods and number of transactions , number of qty sold.
select 
	payment_method,
	count(*) as no_payments,
	Sum(quantity) as no_qty_sold
from walmart
Group BY payment_method

-- Q-2 Identify the highest rated category in ranking branch , displaying the branch , category
-- average rating
SELECT *
FROM
(  SELECT
		branch,
		category,
		AVG(rating) as avg_rating,
		Rank() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
from walmart
GROUP BY 1,2
)
WHERE rank = 1
-------
---Q-3 Identify the busiest day for each branch based on the number of transaction
--- convert char to date and then day find 
SELECT
	date,
	TO_CHAR(TO_DATE(date,'DD/MM/YY'), 'Day') as day_name
from walmart
------ now branch to day find 
Select *
From
	(SELECT
		branch,
		TO_CHAR(TO_DATE(date,'DD/MM/YY'), 'Day') as day_name,
		COUNT(*) as no_trasanctions,
		Rank() OVER(PARTITION BY branch ORDER  BY COUNT(*) DESC) as rank
	from walmart
	GROUP BY 1,2)
WHERE rank = 1
-------------------
-- Q- 4 Calculate the total quantity of items sold per payment_method.List payement_method and total_quantity
SELECT 
	payment_method,
	COUNT(*) as no_payments,
	SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method

---
----Q-5 
-- Determin the average,minimum and maximum rating of category for each city.
-- List the city , average_rating , min_rating and max_rating.
Select
	city,
	category,
	Min(rating) as min_rating,
	Max(rating) as max_rating,
	Avg(rating) as avg_rating
from walmart
GROUP BY 1,2
------------------------------------
--Q-6 Calculate the total profit for each category by considering total_profit as
--(unit_price, quantity, profit_margin).
--List category and total_proft , ordered from highes to lowest profit.

Select
	category,
	sum(total * profit_margin) as profit
From walmart
GROUP BY 1
---- -----------------
------Q-7
----- Determine the most common payment method for each branch.
----- Display branch and the preferred_payment_method.
WITH cte
AS
(select 
	branch,
	payment_method,
	count(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
from walmart
GROUP BY 1,2
)
SELECT *
FROM cte
WHERE rank = 1
-----------------------------------
----Q-8 
---- Categorize sales into 3 group Morning , afternoon , evening
---- Find out which of the shift and number of invoice
--- for time  
Select 
time :: time
from walmart;
-- for time colimn added in walmart db
Select
*,
time :: time
from walmart;
-----------
--- for shifts category 
Select
*,
	CASE 
		WHEN EXTRACT (HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		Else 'Evening'
	END day_time
from walmart
----GROUP BY 1
--- for how many dday time and count sales
Select
CASE 
		WHEN EXTRACT (HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		Else 'Evening'
	END day_time,
	COUNT(*)
from walmart
GROUP BY 1
-----------------
---- By branch find the catgory and count sales
Select
	branch,
CASE 
		WHEN EXTRACT (HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		Else 'Evening'
	END day_time,
	COUNT(*)
from walmart
GROUP BY 1,2
ORDER BY 1,3 DESC
-----------------
----Q-9
----Identify 5 branch with highest descres ratuo in
---- revenue compare to last year(curren year 2023 and lsat year 2022)
--- rdr == last_rev - cr_rev/ls_rev*100
--convert into year of date
SELECT *,
EXTRACT (Year From TO_DATE(date, 'DD/MM/YY')) as formated_date
from walmart
---2022 sales
WITH revenue_2022
AS
(
Select
	branch, 
	Sum(total) as revenue
From walmart
WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
GROUP BY 1
),
revenue_2023
AS
(
   	Select
		branch, 
		Sum(total) as revenue
	From walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)
SELECT 
	ls.branch,
	ls.revenue as l_y_r,
	ls.revenue as cr_y_r,
	ROUND(
			(ls.revenue - cs.revenue)::numeric/
			ls.revenue::numeric * 100,2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN 
revenue_2023 as  CS
ON ls.branch =  cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5