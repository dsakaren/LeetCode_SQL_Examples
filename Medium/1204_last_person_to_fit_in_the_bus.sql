with sorted_queue as
    (
    select
        *
    from queue
    order by turn asc
    offset 0 rows
    )
    , rt as
    (
    select
        *
        ,iif((sum(weight) over ( order by (select null) rows between unbounded preceding and current row )) > 1000, 1, 0) as running_total
    from sorted_queue
    )
select
    top 1 person_name
from rt
where running_total = 0
order by turn desc