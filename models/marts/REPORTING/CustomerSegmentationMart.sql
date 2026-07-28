with visits as (
    select customer_id, count(*) as visit_count
    from {{ ref('checkins') }}
    group by customer_id
),

merch as (
    select customer_id, sum(net_revenue) as merch_spend
    from {{ ref('MerchSalesCOREfct') }}
    group by customer_id
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.loyalty_tier,
    c.is_vip_member,
    coalesce(v.visit_count, 0) as visit_count,
    coalesce(m.merch_spend, 0) as merch_spend,

    -- simple segment logic
    case
        when c.is_vip_member then 'VIP Customer'
        when coalesce(v.visit_count, 0) = 0 then 'Dormant Customer'
        when coalesce(m.merch_spend, 0) > 2000 then 'Merchandise Enthusiast'
        when coalesce(v.visit_count, 0) >= 5 then 'Frequent Visitor'
        else 'Regular Visitor'
    end as customer_segment

from {{ ref('customerCORE') }} c
left join visits v on c.customer_id = v.customer_id
left join merch m on c.customer_id = m.customer_id
