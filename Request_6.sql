#6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct
#for the fiscal year 2021 and in the Indian market.
#The final output contains these fields,
							#customer_code
                            #customer
                            #average_discount_percentage
                            
SELECT
	s.customer_code,
    c.customer,
    ROUND(AVG(pre.pre_invoice_discount_pct)*100,2) as average_discount_percentage
FROM fact_sales_monthly s
JOIN dim_customer c
ON
	s.customer_code=c.customer_code
JOIN fact_pre_invoice_deductions pre
ON
	s.customer_code=pre.customer_code AND
    s.fiscal_year=pre.fiscal_year
WHERE
	s.fiscal_year=2021 AND
    c.market="India"
GROUP BY
	s.customer_code,
    c.customer
ORDER BY
	average_discount_percentage DESC
LIMIT 5;