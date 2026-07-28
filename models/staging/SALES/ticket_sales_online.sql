with source as (

    select * from {{ source('sales', 'ticket_sales_online') }}

),

renamed as (

    select

        try_to_number(sale_id)                      as sale_id,
        try_to_number(customer_id)                   as customer_id,
        try_to_number(ticket_id)                     as ticket_id,
        try_to_decimal(ticket_price, 10, 2)          as ticket_price,
        try_to_decimal(discount_percent, 5, 2)       as discount_percent,
        trim(payment_method)                         as payment_method,
        trim(purchase_channel)                       as purchase_channel,
        try_to_date(purchase_date)                   as purchase_date,
        try_to_timestamp_ntz(purchase_timestamp)     as purchase_timestamp,
        try_to_date(visit_date)                      as visit_date,
        try_to_number(visit_hour)                    as visit_hour,

        case
            when upper(trim(is_online_sale)) = 'TRUE' then true
            when upper(trim(is_online_sale)) = 'FALSE' then false
            else true  -- table-level default since this is the online sales table
        end                                            as is_online_sale,

        try_to_timestamp_ntz(created_at)             as created_at,
        try_to_timestamp_ntz(updated_at)             as updated_at

    from source

)

select * from renamed