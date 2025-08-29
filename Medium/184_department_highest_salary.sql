with cte as 
    (
        select
            e.name as 'Employee'
            , e.salary as 'Salary'
            , d.name as 'Department'
            ,rank() over (partition by departmentId order by salary desc) rnk
        from employee e
        join department d on e.departmentId = d.id
    )
select
    Department
    , Employee
    , Salary
from cte
where rnk = 1