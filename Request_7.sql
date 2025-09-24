#7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. 
#This analysis helps to get an idea of low and high-performing months and take strategic decisions.
#The final report contains these columns: 
										#Month, 
                                        #Year 
                                        #Gross sales Amount
                                        

WITH CTE1 AS
(
SELECT
	s.date,
    s.fiscal_year,
    s.sold_quantity,
    g.gross_price,
    (s.sold_quantity*g.gross_price) AS  gross_sales_amount,
    Month(Date_ADD(s.date, INTERVAL 4 MONTH)) AS fiscal_month
FROM fact_sales_monthly s
JOIN fact_gross_price g
USING (product_code, fiscal_year)
JOIN dim_customer c
USING (customer_code)
WHERE c.customer like "%Atliq Exclusive%"
),
CTE2 AS (
SELECT
	date,
    fiscal_year,
    fiscal_month,
    ROUND(SUM(gross_sales_amount)/1000000,2) as total_gross_sales_amount_mln
FROM CTE1
GROUP BY date, fiscal_year, fiscal_month
ORDER BY fiscal_year, fiscal_month ASC
LIMIT 1000000),
CTE3 AS
(SELECT
	fiscal_month,
	MAX(CASE WHEN fiscal_year=2020 THEN total_gross_sales_amount_mln END) as sales_2020,
    MAX(CASE WHEN fiscal_year=2021 THEN total_gross_sales_amount_mln END) as sales_2021
FROM CTE2
GROUP BY fiscal_month
)

SELECT 
	*
FROM CTE3
GROUP BY fiscal_month
ORDER BY fiscal_month ASC;