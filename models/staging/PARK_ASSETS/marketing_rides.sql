with source as (

    select * from {{ source('park_assets', 'marketing_rides') }}

),

renamed as (

    select

        try_to_number(ride_id)                     as ride_id,
        trim(marketing_name)                       as marketing_name,
        trim(description)                          as description,
        trim(marketing_tagline)                    as marketing_tagline,
        trim(difficulty_level)                     as difficulty_level,
        trim(recommended_for)                      as recommended_for,

        case
            when upper(trim(is_featured)) = 'TRUE' then true
            when upper(trim(is_featured)) = 'FALSE' then false
            else null
        end                                          as is_featured,

        case
            when upper(trim(is_active)) = 'TRUE' then true
            when upper(trim(is_active)) = 'FALSE' then false
            else null
        end                                          as is_active,

        trim(image_url)                            as image_url,
        try_to_timestamp_ntz(created_at)           as created_at,
        try_to_timestamp_ntz(updated_at)           as updated_at

    from source

)

select * from renamed
