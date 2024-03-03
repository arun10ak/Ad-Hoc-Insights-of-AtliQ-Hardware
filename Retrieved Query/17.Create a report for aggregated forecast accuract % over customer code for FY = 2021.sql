-- TASK
/*17. Create a report for aggregated forecast accuract % over customer code for FY = 2021
	Report contains below columns
		(customer code , customer name, markert , total sold quantity , forecast sold quantity,
        net error , net error  , absolute error pct , absolute error pct , forecast accuracy pct)
 */
 
WITH error_table AS (
	SELECT 
		f.customer_code,
        c.customer AS "customer_name",
        c.market,
		SUM(sold_quantity) AS 'total_sold_qty',
		SUM(forecast_quantity) AS 'total_forecast_sold_qty',
		SUM((forecast_quantity - sold_quantity)) AS 'net_error',
		SUM((forecast_quantity - sold_quantity)) *100 /SUM(forecast_quantity) AS 'net_error_pct',
		SUM(ABS(forecast_quantity - sold_quantity)) AS 'abs_error',
		SUM(ABS(forecast_quantity - sold_quantity)) *100 /SUM(forecast_quantity) AS 'abs_error_pct'
	FROM fact_act_fore_monthly f
	JOIN dim_customer c
		USING(customer_code)
	WHERE fiscal_year = 2021
	GROUP BY customer_code
)
SELECT  *,
        IF (et.abs_error_pct > 100, 0 , (100 - et.abs_error_pct)) AS forecast_accuracy_pct 
FROM error_table et 
ORDER BY forecast_accuracy_pct DESC;

-- stored procedure

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
in_fiscal_year INT)
BEGIN
WITH error_table AS (
	SELECT 
		f.customer_code,
        c.customer AS "customer_name",
        c.market,
		SUM(sold_quantity) AS 'total_sold_qty',
		SUM(forecast_quantity) AS 'total_forecast_sold_qty',
		SUM((forecast_quantity - sold_quantity)) AS 'net_error',
		SUM((forecast_quantity - sold_quantity)) *100 /SUM(forecast_quantity) AS 'net_error_pct',
		SUM(ABS(forecast_quantity - sold_quantity)) AS 'abs_error',
		SUM(ABS(forecast_quantity - sold_quantity)) *100 /SUM(forecast_quantity) AS 'abs_error_pct'
FROM fact_act_fore_monthly f
JOIN dim_customer c
USING(customer_code)
WHERE fiscal_year = in_fiscal_year
GROUP BY customer_code
)
SELECT  *,
        IF (et.abs_error_pct > 100, 0 , (100 - et.abs_error_pct)) AS forecast_accuracy_pct 
FROM error_table et 
ORDER BY forecast_accuracy_pct DESC;
END
*/
