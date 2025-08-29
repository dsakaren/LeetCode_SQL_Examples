with cte1 as
    (
        select
            *
            ,lead(num) over ( order by (select null) ) as ld1
        from logs
    )
    , cte2 as
    (
        select
            *
            ,lead(ld1) over ( order by (select null) ) as ld2
        from cte1
    )
select
    distinct num as ConsecutiveNums
from cte2
where (num = ld1) and (num = ld2) and (ld1=ld2)
