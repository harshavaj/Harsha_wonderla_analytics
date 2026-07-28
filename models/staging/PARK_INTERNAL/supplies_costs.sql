with source as (

    select * from {{ source('park_internal', 'supplies_costs') }}

),

renamed as (

    select

        try_to_number(cost_id)                        as cost_id,
        try_to_number(ride_id)                         as ride_id,
        try_to_date(date)                              as cost_date,
        trim(supplier)                                 as supplier,
        try_to_decimal(prop_supplies, 10, 2)           as prop_supplies,
        try_to_decimal(makeup_supplies, 10, 2)         as makeup_supplies,
        try_to_decimal(costume_supplies, 10, 2)        as costume_supplies,
        try_to_decimal(cleaning_supplies, 10, 2)       as cleaning_supplies,
        try_to_decimal(supplies_cost, 10, 2)           as supplies_cost,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed