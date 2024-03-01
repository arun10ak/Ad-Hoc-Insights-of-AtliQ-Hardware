-- 12.Create View for Net Sales. 

CREATE VIEW net_sales_table AS
SELECT *,
	net_invoice_sale_amt - post_invoice_deduction_amt AS  net_sale_table

FROM post_invoice_deduction_table;

SELECT * FROM gdb0041.net_invoice_sale_table;