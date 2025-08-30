with joining as
    (
    select
        distinct p.p_id
        , c.id
    from tree c
    left join tree p on p.p_id = c.id
    where c.p_id is not null
    )
select
    id
    , case 
        when p_id is null then 'Leaf'
        else 'Inner'
        end as 'type'
from joining
union
select
    id
    ,'Root'
from tree
where p_id is null