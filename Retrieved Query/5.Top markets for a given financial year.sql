/*
5.Top markets for a given financial year.
*/

SELECT market,ROUND(SUM(net_sale)/1000000,2) AS 'total_net_sale_IN_MILLIONS'
FROM net_sale_table
WHERE fiscal_year=2021
GROUP BY market
ORDER BY total_net_sale_IN_MILLIONS DESC
LIMIT 5;

-- The above query is use in the various situation so that, we create stored procedure to the above condition using following code.

/*
CREATE PROCEDURE `get_top_n_markets_by_net_sales`(
        	in_fiscal_year INT,
    		in_top_n INT
	)
BEGIN
        	SELECT 
                     market, 
                     round(sum(net_sale)/1000000,2) as net_sales_mln
        	FROM net_sale_table
        	where fiscal_year=in_fiscal_year
        	group by market
        	order by net_sales_mln desc
        	limit in_top_n;
	END
*/
call gdb0041.get_top_n_markets_by_net_sales(2018, 10);
