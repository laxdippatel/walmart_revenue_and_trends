## 📊 SQL Analysis: Walmart Sales Data

This repository includes SQL queries for exploring and analyzing Walmart sales data. Below are the key SQL scripts and business questions addressed.

### 📁 Table Operations

```sql
-- View all records
SELECT * FROM walmart;

-- Drop the table
DROP TABLE walmart;

-- Count total records
SELECT COUNT(*) FROM walmart;

-- Count distinct payment methods
SELECT payment_method, COUNT(*) FROM walmart GROUP BY payment_method;

-- Count unique branches
SELECT COUNT(DISTINCT branch) AS branch FROM walmart;

-- Find minimum quantity sold
SELECT MIN(quantity) FROM walmart;
```

### 📌 Business Questions and Insights

#### Q1: Payment Methods Analysis

```sql
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;
```

#### Q2: Highest Rated Category Per Branch

```sql
SELECT *
FROM (
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY 1,2
) AS ranked
WHERE rank = 1;
```

#### Q3: Busiest Day per Branch

```sql
SELECT *
FROM (
    SELECT
        branch,
        TO_CHAR(TO_DATE(date,'DD/MM/YY'), 'Day') AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY 1,2
) AS busy_day
WHERE rank = 1;
```

#### Q4: Total Quantity Sold by Payment Method

```sql
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;
```

#### Q5: Rating Stats Per City & Category

```sql
SELECT
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY 1,2;
```

#### Q6: Total Profit by Category

```sql
SELECT
    category,
    SUM(total * profit_margin) AS profit
FROM walmart
GROUP BY 1
ORDER BY profit DESC;
```

#### Q7: Most Common Payment Method Per Branch

```sql
WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY 1,2
)
SELECT * FROM cte WHERE rank = 1;
```

#### Q8: Sales by Shift

```sql
SELECT
    CASE 
        WHEN EXTRACT(HOUR FROM time::time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time::time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS day_time,
    COUNT(*)
FROM walmart
GROUP BY 1;

-- By branch
SELECT
    branch,
    CASE 
        WHEN EXTRACT(HOUR FROM time::time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time::time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS day_time,
    COUNT(*)
FROM walmart
GROUP BY 1,2
ORDER BY 1,3 DESC;
```

#### Q9: Top 5 Branches with Decline in Revenue

```sql
WITH revenue_2022 AS (
    SELECT branch, SUM(total) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
    GROUP BY 1
),
revenue_2023 AS (
    SELECT branch, SUM(total) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
    GROUP BY 1
)
SELECT 
    ls.branch,
    ls.revenue AS l_y_r,
    cs.revenue AS cr_y_r,
    ROUND((ls.revenue - cs.revenue)::numeric / ls.revenue::numeric * 100, 2) AS rev_dec_ratio
FROM revenue_2022 AS ls
JOIN revenue_2023 AS cs ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5;
```

---

Let me know if you’d like help adding a [project structure](f), [sample dataset](f), or [Power BI dashboard screenshots](f) to enhance the repository.

