SELECT name
FROM candidate 
where id = (SELECT top 1 candidateId
              FROM vote 
             group by candidateId 
             order by count(*) desc)