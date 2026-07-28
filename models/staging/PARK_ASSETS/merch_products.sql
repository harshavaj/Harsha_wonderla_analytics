with source as (

    select * from {{ source('park_assets', 'merchandise_products') }}

),

renamed as (

    select

        try_to_number(product_id)                as product_id,
        trim(product_name)                       as product_name,
        trim(category)                           as category,
        try_to_decimal(price, 10, 2)             as price,
        try_to_timestamp_ntz(created_at)         as created_at,
        try_to_timestamp_ntz(updated_at)         as updated_at

    from source

)

select * from renamed
