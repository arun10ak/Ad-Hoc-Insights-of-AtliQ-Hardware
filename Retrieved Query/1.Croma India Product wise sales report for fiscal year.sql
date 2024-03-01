/* 
1.Croma India Product wise sales report for fiscal year.
As a product owner i want to generate a report of individual products sales(aggregated on a monthly basis  at the product level)
For Chroma India Customer FY(Fiscal Year)-2021
1.Month
2.Product Name
3.Variant
4.Sold Quantity
5.Gross price per Item
6.Gross price total
*/
SELECT 
	MONTH(f.date) AS "Month",
    p.product AS "Product Name",
	p.variant AS "Variant",
    SUM(f.sold_quantity) AS "Sold Quantity",
    SUM(gp.gross_price) AS "Gross Price Per Item",
    SUM(ROUND((f.sold_quantity * gp.gross_price),2)) AS "Gross Price Total"
    
FROM fact_sales_monthly f
JOIN dim_product p
	ON f.product_code = p.product_code
JOIN fact_gross_price gp
	ON f.product_code = gp.product_code AND f.fiscal_year = gp.fiscal_year
    
WHERE  customer_code = 90002002 AND f.fiscal_year = 2021
GROUP BY 1,2,3;


