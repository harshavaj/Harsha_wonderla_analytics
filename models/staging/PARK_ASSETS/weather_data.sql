with source as (

    select * from {{ source('park_assets', 'weather_data') }}

),

renamed as (

    select

        try_to_number(weather_id)                as weather_id,
        try_to_date(date)                        as weather_date,
        try_to_number(month_number)              as month_number,
        trim(season)                             as season,
        trim(weather_type)                       as weather_type,
        try_to_decimal(temperature_c, 5, 2)      as temperature_c,
        try_to_decimal(rainfall_mm, 6, 2)        as rainfall_mm,
        try_to_decimal(humidity_pct, 5, 2)       as humidity_pct,

        case
            when upper(trim(is_park_open)) = 'TRUE' then true
            when upper(trim(is_park_open)) = 'FALSE' then false
            else null
        end                                        as is_park_open,

        try_to_timestamp_ntz(created_at)          as created_at,
        try_to_timestamp_ntz(updated_at)          as updated_at

    from source

)

select * from renamed
