-- combine online and in-park merchandise sales into one table

with online as (

    select
        sale_id,
        customer_id,
        product_id,
        quantity,
        unit_price,
        total_price,
        discount_applied,
        sale_date,
        'Online' as sale_channel
    from {{ ref('merch_sales_online') }}

),

physical as (

    select
        sale_id,
        customer_id,
        product_id,
        quantity,
        unit_price,
        total_price,
        discount_applied,
        sale_date,
        'Physical' as sale_channel
    from {{ ref('merch_sales_physical') }}

),

combined as (

    select * from online
    union all
    select * from physical

)

select
    sale_id,
    customer_id,
    product_id,
    sale_channel,
    quantity,
    unit_price,
    total_price,
    discount_applied,
    sale_date,

    -- net revenue after discount
    total_price - coalesce(discount_applied, 0) as net_revenue

from combined