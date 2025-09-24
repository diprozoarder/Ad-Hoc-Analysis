#10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?
#The final output contains these fields,
									#division product_code
									#product
                                    #total_sold_quantity
                                    #rank_order
WITH CTE AS
(
SELECT
	p.division,
    s.product_code,
    p.product,
    SUM(s.sold_quantity) as total_sold_quantity,
    DENSE_RANK() OVER(PARTITION BY p.division ORDER BY  SUM(s.sold_quantity) DESC) as drank

FROM fact_sales_monthly s
JOIN dim_product p
USING (product_code)
JOIN fact_gross_price g
USING (product_code, fiscal_year)
WHERE
	fiscal_year=2021
GROUP BY
	p.division,
    s.product_code,
    p.product
)

SELECT
	*
FROM CTE
WHERE drank<=3;