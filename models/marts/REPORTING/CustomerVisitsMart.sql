
select
    ch.checkin_id,
    ch.customer_id,
    ch.ride_id,
    ch.checkin_date,
    ch.actual_wait_minutes,
    t.ticket_id,
    t.sale_channel as ticket_sale_channel

from {{ ref('checkins') }} ch
left join {{ ref('TicketSalesCOREfct') }} t
    on ch.customer_id = t.customer_id
    and ch.checkin_date = t.visit_date
    
