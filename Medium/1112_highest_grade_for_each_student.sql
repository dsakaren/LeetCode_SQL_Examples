select
    student_id
    , course_id
    , grade
from
    (
    select
        *
        ,rank() over ( partition by student_id order by grade desc, course_id asc) as rnk
    from enrollments
    order by course_id asc
    offset 0 rows
    ) subquery
where rnk = 1
order by student_id