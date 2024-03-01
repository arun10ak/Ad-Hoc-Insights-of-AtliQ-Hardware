
-- 7.TOP 5 CUSTOMER (net sale in millions) FOR A GIVEN FISCAL YEAR AND MARKET

SELECT customer,ROUND(SUM(net_sale)/1000000,2) AS 'total_net_sale_IN_MILLIONS'
FROM net_sale_table
WHERE market='india'
AND fiscal_year=2021
GROUP BY customer
ORDER BY total_net_sale_IN_MILLIONS DESC
LIMIT 5;

-- The above query is use in the various situation so that, we create stored procedure to the above condition using following code
/*
CREATE PROCEDURE `get_top_n_customer_by_netsale_`(
in_fiscal_year INT,
in_market VARCHAR(25),
in_top_n INT)
BEGIN

SELECT customer,ROUND(SUM(net_sale)/1000000,2) AS 'total_net_sale_IN_MILLIONS'
FROM net_sale_table
WHERE fiscal_year=in_fiscal_year
AND market=in_market
GROUP BY customer
ORDER BY total_net_sale_IN_MILLIONS DESC
LIMIT in_top_n;
END
*/

call gdb0041.get_top_n_customer_by_netsale_(2020, 'Canada', 3);
