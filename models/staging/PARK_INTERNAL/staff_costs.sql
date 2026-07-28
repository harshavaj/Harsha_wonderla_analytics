with source as (

    select * from {{ source('park_internal', 'staff_costs') }}

),

renamed as (

    select

        try_to_number(cost_id)                        as cost_id,
        try_to_number(ride_id)                         as ride_id,
        try_to_date(date)                              as cost_date,
        try_to_decimal(staff_cost, 10, 2)              as staff_cost,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed