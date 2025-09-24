#4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020?
#The final output contains these fields, 
								#segment
                                #product_count_2020
                                #product_count_2021
                                #difference

WITH CTE1 AS(
SELECT
	p.segment,
    s.fiscal_year,
    COUNT(DISTINCT product_code) as unique_product
FROM fact_sales_monthly s
JOIN dim_product p
USING (product_code)
WHERE fiscal_year IN (2020,2021)
GROUP BY p.segment,s.fiscal_year
),
CTE2 AS
(
SELECT
	segment,
    MAX(CASE WHEN fiscal_year=2020 THEN unique_product END) AS 2020_product,
    MAX(CASE WHEN fiscal_year=2021 THEN unique_product END) AS 2021_product
FROM CTE1
GROUP BY segment
),

CTE3 AS
(

SELECT
	segment,
	2020_product,
    2021_product,
    ROUND(MAX(2021_product-2020_product)*100/MAX(2020_product),2) AS product_chg_pct
FROM CTE2
GROUP BY segment, 2020_product, 2021_product
)
SELECT
	*
FROM CTE3
ORDER BY product_chg_pct DESC;
                                