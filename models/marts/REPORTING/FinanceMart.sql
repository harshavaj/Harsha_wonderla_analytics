with ticket_by_day as (
    select visit_date as report_date, sum(net_revenue) as ticket_revenue
    from {{ ref('TicketSalesCOREfct') }}
    group by visit_date
),
merch_by_day as (
    select sale_date as report_date, sum(net_revenue) as merch_revenue
    from {{ ref('MerchSalesCOREfct') }}
    group by sale_date
),
cost_by_day as (
    select cost_date as report_date, sum(amount) as operating_cost
    from {{ ref('OperatingExpenseCOREfct') }}
    group by cost_date
)
select
    t.report_date, t.ticket_revenue, m.merch_revenue, c.operating_cost
from ticket_by_day t
left join merch_by_day m on t.report_date = m.report_date
left join cost_by_day c on t.report_date = c.report_date
