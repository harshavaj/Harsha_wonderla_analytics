-- combine online and physical ticket sales into one table

with online as (

    select
        sale_id,
        customer_id,
        ticket_id,
        ticket_price,
        discount_percent,
        payment_method,
        purchase_date,
        visit_date,
        visit_hour,
        'Online' as sale_channel
    from {{ ref('ticket_sales_online') }}

),

physical as (

    select
        sale_id,
        customer_id,
        ticket_id,
        ticket_price,
        discount_percent,
        payment_method,
        purchase_date,
        visit_date,
        visit_hour,
        'Physical' as sale_channel
    from {{ ref('ticket_sales_physical') }}

),

combined as (

    select * from online
    union all
    select * from physical

)

select
    sale_id,
    customer_id,
    ticket_id,
    sale_channel,
    ticket_price,
    discount_percent,
    payment_method,
    purchase_date,
    visit_date,
    visit_hour,

    -- discount category
    case
        when discount_percent = 0 or discount_percent is null then 'No Discount'
        when discount_percent < 15 then 'Small Discount'
        else 'Big Discount'
    end as discount_category,

    -- same day vs advance purchase
    case
        when purchase_date = visit_date then true
        else false
    end as is_same_day_purchase,

    -- visit time category
    case
        when visit_hour < 12 then 'Morning'
        when visit_hour < 17 then 'Afternoon'
        else 'Evening'
    end as visit_time_category,

    -- net revenue after discount
    ticket_price - (ticket_price * discount_percent / 100) as net_revenue

from combined
