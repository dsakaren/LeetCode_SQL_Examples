with cte as
    (
    select
        *
        ,lead(id) over ( order by (select null) ) as next_seat
        ,lag(id) over ( order by (select null) ) as prev_seat
    from seat
    )
select
    case when (next_seat is null and (select count(*) from seat) % 2 != 0) then id
           when id % 2 = 0 then prev_seat
           else next_seat
           end as 'id'
    , student
from cte
order by 1 asc