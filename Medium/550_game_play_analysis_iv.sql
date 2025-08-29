declare @total_users int
set @total_users = (
                    select
                        count(distinct(player_id))
                    from activity        
                );

with first_login as
    (
        select
            a1.player_id
            , min(a1.event_date) as first_login_date
        from activity a1
        group by a1.player_id
    )
    , filtered_users as
    (
        select
            count(distinct(fl.player_id)) as filter_count
        from first_login fl
        join activity a 
                    on fl.player_id = a.player_id
                    and (datediff(day, fl.first_login_date, a.event_date) = 1)
    )
select
    round(1.00 * filter_count / @total_users, 2) as fraction
from filtered_users
