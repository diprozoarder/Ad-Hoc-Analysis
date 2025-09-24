#9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?
#The final output contains these fields,
									#channel
                                    #gross_sales_mln percentage
                                    
WITH CTE1 AS
(
SELECT
	c.channel,
    ROUND(SUM(s.sold_quantity*g.gross_price)/1000000,2) as gross_sales_mln
FROM fact_sales_monthly s
JOIN fact_gross_price g
USING (fiscal_year, product_code)
JOIN dim_customer c
USING (customer_code)
WHERE fiscal_year=2021
GROUP BY c.channel
)
SELECT
	channel,
    gross_sales_mln,
   ROUND(gross_sales_mln*100/SUM(gross_sales_mln) OVER (), 2)  as percentage
FROM CTE1
ORDER BY gross_sales_mln DESC;