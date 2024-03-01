-- STORED PROCEDURE
-- TASK 4
/*4.Stored Procedure for market Badge 
CREATE A STORED PROCEDURE THAT CAN DETERMINE THE MARKET BADGE BASED ON THE FOLLOWING LOGIC

IF TOTAL QUANTITY > 5MILLION(5000000),THAT MARKET IS CONSIDERED AS "GOLD" ELSE IT IS "SILVER"
	MY  INPUT WILL BE
		--> MARKER
		--> FISCAL YEAR
	OUTPUT 
		--> MARKET BADGE
 */
 
 -- LOGIC 
SELECT 
    c.market,
    SUM(s.sold_quantity) AS total_quantity,
    IF((SUM(s.sold_quantity) > 5000000),
        'GOLD',
        'SILVER') AS badge
FROM fact_sales_monthly s
JOIN dim_customer c 
	ON c.customer_code = s.customer_code
GROUP BY c.market;

SELECT 
    SUM(s.sold_quantity) AS total_quantity,
    IF((SUM(s.sold_quantity) > 5000000),
        'GOLD',
        'SILVER') AS badge
FROM fact_sales_monthly s
JOIN dim_customer c 
	ON c.customer_code = s.customer_code
WHERE GET_FISCAL_YEAR(s.date) = 2021
        AND c.market = 'INDIA'
GROUP BY c.market;

-- USING STORED PROCEDURE
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
mrt VARCHAR(25),
fy INT)
BEGIN
	SELECT 
		IF((SUM(s.sold_quantity) > 5000000),
			'GOLD','SILVER') AS badge
	FROM fact_sales_monthly s
	JOIN dim_customer c 
		ON c.customer_code = s.customer_code
	WHERE GET_FISCAL_YEAR(s.date) = fy
			AND c.market = mrt
	GROUP BY c.market;
END 
*/
call gdb0041.get_market_badge('india', 2021);
