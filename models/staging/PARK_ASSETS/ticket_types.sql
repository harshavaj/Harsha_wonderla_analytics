with source as (

    select * from {{ source('park_assets', 'ticket_types') }}

),

renamed as (

    select

        try_to_number(ticket_id)                as ticket_id,
        trim(ticket_type_name)                  as ticket_type_name,
        trim(description)                       as description,
        try_to_decimal(price, 10, 2)             as price,

        case
            when upper(trim(includes_fast_pass)) = 'TRUE' then true
            when upper(trim(includes_fast_pass)) = 'FALSE' then false
            else null
        end                                      as includes_fast_pass,

        case
            when upper(trim(includes_vip_benefits)) = 'TRUE' then true
            when upper(trim(includes_vip_benefits)) = 'FALSE' then false
            else null
        end                                      as includes_vip_benefits,

        try_to_date(launch_date)                 as launch_date,
        try_to_timestamp_ntz(created_at)         as created_at,
        try_to_timestamp_ntz(updated_at)         as updated_at

    from source

)

select * from renamed
