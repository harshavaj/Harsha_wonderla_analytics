with source as (

    select * from {{ source('customer_data', 'customers') }}

),

renamed as (

    select

        try_to_number(customer_id)                     as customer_id,
        trim(first_name)                                as first_name,
        trim(last_name)                                 as last_name,
        lower(trim(email))                              as email,
        trim(phone)                                     as phone,
        trim(address)                                   as address,
        trim(city)                                      as city,
        trim(state)                                     as state,
        trim(pin_code)                                  as pin_code,
        try_to_number(age)                              as age,
        trim(gender)                                    as gender,

        case
            when upper(trim(is_vip_member)) = 'TRUE' then true
            when upper(trim(is_vip_member)) = 'FALSE' then false
            else null
        end                                              as is_vip_member,

        case
            when upper(trim(marketing_opt_in)) = 'TRUE' then true
            when upper(trim(marketing_opt_in)) = 'FALSE' then false
            else null
        end                                              as marketing_opt_in,

        try_to_number(preferred_thrill_level)            as preferred_thrill_level,
        try_to_number(loyalty_points)                    as loyalty_points,
        try_to_date(registration_date)                   as registration_date,
        try_to_timestamp_ntz(created_at)                 as created_at,
        try_to_timestamp_ntz(updated_at)                 as updated_at

    from source

)

select * from renamed
