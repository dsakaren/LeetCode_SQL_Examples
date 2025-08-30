select
    f1.followee as follower
    ,count(*) as num
from follow f1
where f1.followee in (select follower from follow where follower is not null)
group by f1.followee
order by f1.followee asc