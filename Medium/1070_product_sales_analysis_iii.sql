select
    l.product_id
    , l.first_year
    , r.quantity
    , r.price
from 
    (select
        product_id
        ,min(year) as first_year
    from sales
    group by product_id) l
join sales r on l.product_id = r.product_id
    and l.first_year = r.year