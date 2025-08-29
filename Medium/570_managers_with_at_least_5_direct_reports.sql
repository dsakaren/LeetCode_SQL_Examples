select
    r.name
from
    (
    select
        managerId
    from employee
    where managerId is not null
    group by managerId
    having count(*) >= 5
    ) l
join employee r on l.managerId = r.id