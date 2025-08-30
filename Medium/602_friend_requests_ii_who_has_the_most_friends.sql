with cte as
    (
        select
            requester_id as id
        from requestaccepted
        union all
        select
            accepter_id
        from requestaccepted
    )
select
    top 1 id
    , count(*) as num
from cte
group by id
order by 2 desc