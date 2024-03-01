-- 10.Create View for Net Invoice Sales. 

CREATE VIEW net_invoice_sale_table AS 
SELECT *,
ROUND((total_gross_price - pre_invoice_deduction_amt ),2) AS net_invoice_sale_amt
FROM pre_invoice_deduction_table;

SELECT * FROM gdb0041.net_invoice_sale_table;