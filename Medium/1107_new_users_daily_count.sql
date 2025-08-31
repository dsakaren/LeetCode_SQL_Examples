with cte as
    (
    select
        *
        , min(activity_date) over ( partition by user_id) as min_login
    from traffic
    where activity = 'login'
    )
select
    cte.min_login as login_date
    , count(distinct(user_id)) as user_count
from cte
where min_login >= dateadd(day, -90, '2019-06-30')
group by cte.min_login
having count(distinct(user_id)) > 0