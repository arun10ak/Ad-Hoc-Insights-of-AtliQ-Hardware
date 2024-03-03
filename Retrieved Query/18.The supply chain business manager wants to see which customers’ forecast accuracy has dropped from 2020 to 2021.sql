-- TASK
/*
18.The supply chain business manager wants to see which customers’ forecast accuracy has dropped from 2020 to 2021.
 Provide a complete report with these columns: 
	customer_code, customer_name, market, forecast_accuracy_2020, forecast_accuracy_2021 
*/
-- FOR 2022
CREATE TEMPORARY TABLE forecast_accuracy_2020
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
		WHERE fiscal_year = 2020
		GROUP BY customer_code
	)
	SELECT  *,
			IF (et.abs_error_pct > 100, 0 , (100 - et.abs_error_pct)) AS forecast_accuracy_pct 
	FROM error_table et 
	ORDER BY forecast_accuracy_pct DESC;
    
SELECT * FROM forecast_accuracy_2020;

-- FOR 2021

CREATE TEMPORARY TABLE forecast_accuracy_2021
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
    
SELECT * FROM forecast_accuracy_2021;

-- NOW JOIN THE ABOVE TWO TABLE WITH 2020 > 2021 

SELECT 
	f_20.customer_code,
	f_20.customer_name,
	f_20.market,
    f_20.forecast_accuracy_pct AS forecast_accuracy_2020,
    f_21.forecast_accuracy_pct AS forecast_accuracy_2021
FROM forecast_accuracy_2020 f_20
JOIN forecast_accuracy_2021 f_21
ON f_20.customer_code = f_21.customer_code
WHERE f_20.forecast_accuracy_pct > f_21.forecast_accuracy_pct
ORDER BY f_20.forecast_accuracy_pct DESC;