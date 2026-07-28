with source as (

    select * from {{ source('sales', 'merchandise_sales_online') }}

),

renamed as (

    select

        try_to_number(sale_id)                        as sale_id,
        try_to_number(customer_id)                     as customer_id,
        try_to_number(product_id)                      as product_id,
        trim(product_name)                             as product_name,
        trim(category)                                 as category,
        try_to_number(quantity)                        as quantity,
        try_to_decimal(unit_price, 10, 2)              as unit_price,
        try_to_decimal(total_price, 10, 2)             as total_price,
        try_to_decimal(discount_applied, 10, 2)        as discount_applied,
        trim(payment_method)                           as payment_method,
        try_to_date(sale_date)                         as sale_date,
        try_to_timestamp_ntz(sale_timestamp)           as sale_timestamp,
        try_to_number(haunted_house_id)                as haunted_house_id,
        trim(staff_member)                             as staff_member,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at,

        -- flag rows affected by the known truncation defect in the source data
        -- (product_name gets cut off and all trailing fields are blank)
        case
            when quantity is null and total_price is null and sale_date is null
                then true
            else false
        end                                              as is_incomplete_record

    from source

)

select * from renamed