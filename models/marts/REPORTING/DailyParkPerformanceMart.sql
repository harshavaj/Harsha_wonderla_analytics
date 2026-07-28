with ticket_by_day as (
    select visit_date, sum(net_revenue) as ticket_revenue
    from {{ ref('TicketSalesCOREfct') }}
    group by visit_date
),
merch_by_day as (
    select sale_date, sum(net_revenue) as merch_revenue
    from {{ ref('MerchSalesCOREfct') }}
    group by sale_date
),
cost_by_day as (
    select cost_date, sum(amount) as total_cost
    from {{ ref('OperatingExpenseCOREfct') }}
    group by cost_date
)
select
    d.date_day,
    coalesce(t.ticket_revenue, 0) as ticket_revenue,
    coalesce(m.merch_revenue, 0) as merch_revenue,
    coalesce(c.total_cost, 0) as total_cost
from {{ ref('dateCORE') }} d
left join ticket_by_day t on d.date_day = t.visit_date
left join merch_by_day m on d.date_day = m.sale_date
left join cost_by_day c on d.date_day = c.cost_date