-- TASK 3
/* 3.Generate a yearly report for Croma India
 where there are two columns
1. Fiscal Year
2. Total Gross Sales amount In that year from Croma
*/
SELECT 
    get_fiscal_year(s.date) AS 'fiscal_year',
    ROUND(SUM(gp.gross_price * s.sold_quantity), 2) AS 'total_gross_price'
FROM
    fact_sales_monthly s
        JOIN
    fact_gross_price gp ON gp.product_code = s.product_code 
        AND gp.fiscal_year = GET_FISCAL_YEAR(s.date)
WHERE
    customer_code = 90002002
GROUP BY 1
ORDER BY 1 ASC;