-- 11.Create View for Post-Invoice Deduction Amount. 

CREATE VIEW post_invoice_pct_table AS 
SELECT 
	nis.date,
	nis.fiscal_year,
	nis.customer_code,
	nis.market,
	nis.product_code,
	nis.product,
	nis.variant,
	nis.sold_quantity,
	nis.gross_price,
	nis.total_gross_price,
	nis.pre_invoice_deduction_pct,
    nis.pre_invoice_deduction_amt,
    nis.net_invoice_sale_amt,
	ROUND((discounts_pct + other_deductions_pct),2) AS post_invoice_deductions_pct
FROM net_invoice_sale_table nis
JOIN fact_post_invoice_deductions post
	 ON nis.customer_code = post.customer_code 
		AND nis.product_code = post.product_code;


CREATE VIEW post_invoice_deduction_table AS 
SELECT *,
		ROUND((post_invoice_deductions_pct * net_invoice_sale_amt),2) AS post_invoice_deduction_amt
FROM post_invoice_deduction_pct_table;

SELECT * FROM gdb0041.post_invoice_deduction_table;

        
        
        
        
	
