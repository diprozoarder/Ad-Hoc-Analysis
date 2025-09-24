#3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.
#The final output contains 2 fields,
						#segment
                        #product_count

SELECT p.Segment,
       COUNT(DISTINCT s.product_code) AS product_count
FROM dim_product p
JOIN fact_sales_monthly s USING (product_code)
GROUP BY SEGMENT
ORDER BY product_count DESC;