# 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

SELECT region,
       market,
       customer
FROM dim_customer
WHERE customer like "%Atliq Exclusive%"
  AND region="APAC"
GROUP BY region,
         market,
         customer
ORDER BY market ASC;