-- 13. FY-2021 FOR TOP 10 customer BY %NET SALES

WITH cte AS (
	SELECT 
		customer,
		SUM(net_sale_amt)/1000000 AS tot_ns
	FROM net_sales_table
	WHERE fiscal_year =2021
	GROUP BY customer)

SELECT *,
	tot_ns*100/SUM(tot_ns) OVER() AS pct_ns FROM cte
ORDER BY tot_ns  DESC
LIMIT 10;