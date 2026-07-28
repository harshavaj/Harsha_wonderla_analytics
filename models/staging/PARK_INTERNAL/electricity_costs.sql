with source as (

    select * from {{ source('park_internal', 'electricity_costs') }}

),

renamed as (

    select

        try_to_number(cost_id)                        as cost_id,
        try_to_number(ride_id)                         as ride_id,
        try_to_date(date)                              as cost_date,
        try_to_decimal(hours_of_operation, 6, 2)       as hours_of_operation,
        try_to_decimal(lighting_power, 10, 2)          as lighting_power,
        try_to_decimal(climate_control_power, 10, 2)   as climate_control_power,
        try_to_decimal(special_effects_power, 10, 2)   as special_effects_power,
        try_to_decimal(electricity_cost, 10, 2)        as electricity_cost,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed
