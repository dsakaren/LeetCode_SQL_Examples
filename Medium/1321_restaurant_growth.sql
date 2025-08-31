with daily_sales as
    (
    select
        visited_on
        ,sum(amount) as daily_total
    from customer
    group by visited_on
    order by visited_on
    offset 0 rows
    ),
    weekly_sales as
    (
    select
        visited_on
        ,sum(daily_total) over ( order by visited_on rows between 6 preceding and current row) as amount
        ,round(1.00*sum(daily_total) over ( order by visited_on rows between 6 preceding and current row) / 7,2) as average_amount
    from daily_sales
    )
select
    *
from weekly_sales
where visited_on >= ( select dateadd(day, 6, min(visited_on)) from customer )

