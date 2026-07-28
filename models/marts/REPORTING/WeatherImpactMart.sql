
with ticket_by_day as (
    select visit_date, sum(net_revenue) as ticket_revenue, count(*) as tickets_sold
    from {{ ref('TicketSalesCOREfct') }}
    group by visit_date
)

select
    w.weather_date,
    w.rainfall_mm,
    w.temperature_c,
    w.park_status,
    coalesce(t.ticket_revenue, 0) as ticket_revenue,
    coalesce(t.tickets_sold, 0) as tickets_sold,

    -- simple attendance category based on tickets sold
    case
        when coalesce(t.tickets_sold, 0) = 0 then 'No Visitors'
        when t.tickets_sold < 20 then 'Low'
        when t.tickets_sold < 50 then 'Medium'
        else 'High'
    end as attendance_category

from {{ ref('weatherCORE') }} w
left join ticket_by_day t on w.weather_date = t.visit_date