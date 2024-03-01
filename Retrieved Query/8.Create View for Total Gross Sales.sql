/* 8.Create View for Total Gross Sales.
It should have the following columns,
date, fiscal_year, customer_code, customer, market, product_code, product, variant,
sold_quanity, gross_price_per_item, gross_price_total 
*/

CREATE VIEW gross_sales_table AS 
 SELECT 
    s.date,
    s.fiscal_year,
    c.customer_code,
    c.customer,
    c.market,
    p.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    gp.gross_price AS gross_price_per_item,
    ROUND((s.sold_quantity * gp.gross_price),2) AS 'total_gross_price'
FROM fact_sales_monthly s
JOIN dim_customer c ON c.customer_code = s.customer_code
JOIN dim_product p ON p.product_code = s.product_code
JOIN fact_gross_price gp ON gp.product_code = s.product_code
AND gp.fiscal_year = s.fiscal_year;

SELECT * FROM gdb0041.gross_sales_table;