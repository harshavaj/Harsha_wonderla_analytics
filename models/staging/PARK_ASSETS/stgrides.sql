with source as (

    select * from {{ source('park_assets', 'rides') }}

),

renamed as (

    select

        try_to_number(ride_id)                   as ride_id,
        trim(ride_name)                          as ride_name,
        trim(ride_type)                          as ride_type,
        try_to_number(thrill_level)               as thrill_level,
        try_to_number(duration_seconds)           as duration_seconds,
        try_to_number(min_height_cm)              as min_height_cm,
        try_to_number(max_capacity_per_group)     as max_capacity_per_group,
        try_to_number(max_daily_capacity)         as max_daily_capacity,

        case
            when upper(trim(is_water_ride)) = 'TRUE' then true
            when upper(trim(is_water_ride)) = 'FALSE' then false
            else null
        end                                        as is_water_ride,

        trim(park_zone)                            as park_zone,
        trim(ride_status)                          as ride_status,
        try_to_timestamp_ntz(created_at)           as created_at,
        try_to_timestamp_ntz(updated_at)           as updated_at

    from source

)

select * from renamed
