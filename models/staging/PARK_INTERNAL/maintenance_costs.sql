with source as (

    select * from {{ source('park_internal', 'maintenance_costs') }}

),

renamed as (

    select

        try_to_number(cost_id)                        as cost_id,
        try_to_number(ride_id)                         as ride_id,
        try_to_date(date)                              as cost_date,
        trim(maintenance_type)                         as maintenance_type,
        try_to_decimal(equipment_maintenance, 10, 2)   as equipment_maintenance,
        try_to_decimal(prop_repairs, 10, 2)            as prop_repairs,
        try_to_decimal(structural_repairs, 10, 2)      as structural_repairs,
        try_to_decimal(maintenance_cost, 10, 2)        as maintenance_cost,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed