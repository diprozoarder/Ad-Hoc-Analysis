#2. What is the percentage of unique product increase in 2021 vs. 2020? 
#The final output contains these fields, 
						--- unique_products_2020
                        ---- unique_products_2021
                        --- percentage_chg

WITH CTE1 AS
  (SELECT fiscal_year,
          COUNT(DISTINCT product_code) AS unique_product
   FROM fact_sales_monthly
   WHERE fiscal_year IN (2020,
                         2021)
   GROUP BY fiscal_year),
     CTE2 AS
  (SELECT MAX(CASE
                  WHEN fiscal_year=2020 THEN unique_product
              END) AS unique_product_2020,
          MAX(CASE
                  WHEN fiscal_year=2021 THEN unique_product
              END) AS unique_product_2021
   FROM CTE1)
SELECT unique_product_2020,
       unique_product_2021,
       (unique_product_2021-unique_product_2020)*100/unique_product_2020 AS pct_chg
FROM CTE2;