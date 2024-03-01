-- TASK 2
/* 
2.Gross Monthly total sales report for Croma.
As a product owner i need an aggregated  monthly sales report for  croma india customer so that
how  much sales this particular customer is generateing for atliq and manage relationship accordingly

Report contains:
1.Month
2.Total gross sales amount to croma india in this month

*/
SELECT 
    s.date, 
    ROUND(SUM(gp.gross_price * s.sold_quantity),2) AS  'total_gross_price'
FROM fact_sales_monthly s
JOIN fact_gross_price gp 
	ON gp.product_code = s.product_code
		AND gp.fiscal_year = GET_FISCAL_YEAR(s.date)
WHERE customer_code = 90002002
GROUP BY s.date
ORDER BY s.date ASC;

/* 
The above query is use in the various situation so that,
we create stored procedure to the above condition using following code 

CREATE PROCEDURE `get_monthly_gross_sales_for_customer` (c_code INT)
BEGIN
SELECT 
    s.date, 
    ROUND(SUM(gp.gross_price * s.sold_quantity),2) AS  'total_gross_price'
	FROM fact_sales_monthly s
	JOIN fact_gross_price gp 
		ON gp.product_code = s.product_code
			AND gp.fiscal_year = GET_FISCAL_YEAR(s.date)
	WHERE customer_code = c_code
	GROUP BY s.date
	ORDER BY s.date ASC;
END
*/

call gdb0041.get_monthly_gross_sales_for_customer(90002002);