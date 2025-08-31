with cte as
    (
    select
        m.host_team as team_id
        , case when m.host_goals > m.guest_goals then 3
            when m.host_goals = m.guest_goals then 1
            else 0
            end as 'num_points'
    from matches m
    union all
    select
        m.guest_team as team_id
        , case when m.host_goals < m.guest_goals then 3
            when m.host_goals = m.guest_goals then 1
            else 0
            end as 'num_points'
    from matches m
    )
    , subquery as
    (
    select
        t.team_id
        ,t.team_name
        ,isnull(sum(cte.num_points), 0) as num_points
    from teams t
    left join cte on t.team_id = cte.team_id
    group by t.team_id, t.team_name
    )
select
    *
from subquery
order by 3 desc, 1 asc