with source as (

    select * from {{ source('park_internal', 'checkins') }}

),

renamed as (

    select

        try_to_number(checkin_id)                     as checkin_id,
        try_to_number(customer_id)                     as customer_id,
        try_to_number(ticket_id)                        as ticket_id,
        try_to_number(haunted_house_id)                 as ride_id,
        try_to_date(checkin_date)                      as checkin_date,
        trim(checkin_time)                             as checkin_time,
        try_to_timestamp_ntz(checkin_timestamp)        as checkin_timestamp,
        try_to_number(queue_length)                     as queue_length,
        try_to_number(estimated_wait_minutes)           as estimated_wait_minutes,
        try_to_number(actual_wait_minutes)              as actual_wait_minutes,
        try_to_decimal(wait_accuracy, 8, 2)             as wait_accuracy,

        case
            when upper(trim(is_peak_hour)) = 'TRUE' then true
            when upper(trim(is_peak_hour)) = 'FALSE' then false
            else null
        end                                               as is_peak_hour,

        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed