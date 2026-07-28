with ticket_totals as (
    select
        customer_id,
        sum(net_revenue) as ticket_revenue,
        count(*) as ticket_count
    from {{ ref('TicketSalesCOREfct') }}
    group by customer_id
),

merch_totals as (
    select
        customer_id,
        sum(net_revenue) as merch_revenue
    from {{ ref('MerchSalesCOREfct') }}
    group by customer_id
),

visit_totals as (
    select
        customer_id,
        count(*) as visit_count,
        max(checkin_date) as last_visit_date
    from {{ ref('checkins') }}
    group by customer_id
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.loyalty_tier,

    coalesce(t.ticket_revenue, 0) as ticket_revenue,
    coalesce(t.ticket_count, 0) as ticket_count,
    coalesce(m.merch_revenue, 0) as merch_revenue,
    coalesce(v.visit_count, 0) as visit_count,
    v.last_visit_date

from {{ ref('customerCORE') }} c
left join ticket_totals t on c.customer_id = t.customer_id
left join merch_totals m on c.customer_id = m.customer_id
left join visit_totals v on c.customer_id = v.customer_id

