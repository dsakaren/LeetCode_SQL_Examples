declare @today as datetime
set @today = '2019-06-23';

with last_year as
    (
    select
        o.book_id
        ,sum(quantity) as last_year_orders
    from orders o
    where o.dispatch_date >= dateadd(year, -1, @today)
    group by o.book_id
    )
select
    b.book_id
    , b.name
from books b
left join last_year ly on b.book_id = ly.book_id
where b.available_from < dateadd(month, -1, @today)
and (ly.last_year_orders < 10 or ly.last_year_orders is null)