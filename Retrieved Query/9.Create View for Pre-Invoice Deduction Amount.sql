/*8.Create View for Total Gross Sales*/

CREATE VIEW pre_invoice_deduction_table AS 
WITH cte AS (
SELECT
	s.date,
	s.fiscal_year,
	s.customer_code,
	c.market,
	s.product_code,
	p.product,
	p.variant,
	s.sold_quantity,
	ROUND(g.gross_price,2) as gross_price_per_item,
	ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
	ROUND(pre.pre_invoice_discount_pct,2) as pre_invoice_discount_pct
FROM fact_sales_monthly s
JOIN dim_customer c
	ON s.customer_code = c.customer_code
JOIN dim_product p
	ON s.product_code=p.product_code
JOIN fact_gross_price g
	ON g.fiscal_year=s.fiscal_year
		AND g.product_code=s.product_code
JOIN fact_pre_invoice_deductions as pre
		ON pre.customer_code = s.customer
ORDER BY s.date) 

SELECT *,
	ROUND((total_gross_price * pre_invoice_deduction_pct),2) AS `pre_invoice_deduction_amt` 
FROM cte;


SELECT * FROM gdb0041.pre_invoice_deduction_table;