-- 14. Find customer wise net sales distibution per region for FY 2021

with cte1 as (
		select 
        	    c.customer,
				c.region,
				round(sum(net_sale_amt)/1000000,2) as net_sales_mln
                from net_sales_table ns
                join dim_customer c
                    on ns.customer_code=c.customer_code
		where fiscal_year=2021
		group by c.customer, c.region)
	select
             *,
             net_sales_mln*100/sum(net_sales_mln) over (partition by region) as pct_share_region
	from cte1
	order by region, pct_share_region desc