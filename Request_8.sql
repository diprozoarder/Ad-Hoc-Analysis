#8. In which quarter of 2020, got the maximum total_sold_quantity?
#The final output contains these fields sorted by
							#the total_sold_quantity,
                            #Quarter total_sold_quantity

WITH CTE1 AS
(
SELECT
	s.date,
    s.fiscal_year,
    s.sold_quantity
FROM fact_sales_monthly s
JOIN fact_gross_price g
USING (product_code, fiscal_year)
JOIN dim_customer c
USING (customer_code)
WHERE s.fiscal_year like 2020
),

CTE2 AS
(
SELECT
	(CASE
    WHEN MONTH(date_add(date, INTERVAL 4 MONTH)) IN (1,2,3) THEN "Q 1"
    WHEN MONTH(date_add(date, INTERVAL 4 MONTH)) IN (4,5,6) THEN "Q 2"
    WHEN MONTH(date_add(date, INTERVAL 4 MONTH)) IN (7,8,9) THEN "Q 3"
    ELSE "Q 4"
    END) AS qtr,
    sold_quantity
FROM CTE1)
SELECT
	qtr,
    ROUND(SUM(sold_quantity)/1000000,2) as total_sold_quantity
FROM CTE2
GROUP BY qtr;