with cte as
    (
    select
        *
        ,rank() over ( partition by customer_id order by order_date asc) as rnk
    from delivery d
    )
select
    round(100.00 * sum(case when cte.order_date = cte.customer_pref_delivery_date then 1 else 0 end)
    / count(*),2) as immediate_percentage
from cte
where cte.rnk = 1