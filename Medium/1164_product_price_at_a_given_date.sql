select
    product_id
    , new_price as price
from products
where change_date = '2019-08-16'
union
select
    product_id
    , 10
from products
group by product_id
having min(change_date) > '2019-08-16'
union
select
    l.product_id
    , r.new_price
from
    (select
        product_id
        ,max(change_date) as max_date
    from products
    where change_date < '2019-08-16'
    and product_id not in (select product_id from products where change_date = '2019-08-16')
    group by product_id) l
join products r on l.product_id = r.product_id and l.max_date = r.change_date