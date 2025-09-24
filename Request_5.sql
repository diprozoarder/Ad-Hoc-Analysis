#5. Get the products that have the highest and lowest manufacturing costs.
#The final output should contain these fields, 
								#product_code
                                #product manufacturing_cost

WITH CTE1 AS
(
SELECT
	p.product_code,
    p.product,
    AVG(m.manufacturing_cost) as avg_manufacturing_cost
FROM dim_product p
JOIN fact_manufacturing_cost m
USING (product_code)
GROUP BY p.product_code, p.product
)
SELECT
	product_code,
    product,
   ROUND(avg_manufacturing_cost,2)
FROM CTE1
WHERE
	avg_manufacturing_cost= (SELECT MAX(avg_manufacturing_cost) FROM CTE1) OR
    avg_manufacturing_cost= (SELECT MIN(avg_manufacturing_cost) FROM CTE1)
ORDER BY
		avg_manufacturing_cost DESC
LIMIT 2;