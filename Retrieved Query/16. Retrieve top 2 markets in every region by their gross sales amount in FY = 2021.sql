-- 16. Retrieve top 2 markets in every region by their gross sales amount in FY = 2021

WITH cte AS (
	SELECT 
		c.market,
		c.region,
		ROUND((SUM(gs.total_gross_price)) / 1000000,2) AS "gross_sales_mln"
	FROM gross_sales_table gs
	JOIN dim_customer c
		ON  gs.customer_code = c.customer_code 
			AND gs.customer = c.customer
	WHERE gs.fiscal_year = 2021
	GROUP BY c.market,c.region ),
 cte2 AS (
	 SELECT * ,
			dense_rank() over (partition by region order by gross_sales_mln desc) as 't_rank'
	 FROM cte)

SELECT * 
FROM cte2
WHERE t_rank<=2;

call gdb0041.get_top_2_market_per_region_by_gross_sales_mln(2019, 1);


     