with direct_reports as
    (
        select
            e.employee_id
        from employees e
        where e.employee_id != 1
        and e.manager_id = 1
    )
    ,
    level_1 as
    (
        select
            e.employee_id
        from employees e
        where e.manager_id in (select * from direct_reports)
    )
    ,
    level_2 as
    (
        select
            e.employee_id
        from employees e
        where e.manager_id in (select * from level_1)
    )
select
    *
from direct_reports
union
select
    *
from level_1
union
select
    *
from level_2