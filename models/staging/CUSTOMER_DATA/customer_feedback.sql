with source as (

    select * from {{ source('customer_data', 'customer_feedbacks') }}

),

renamed as (

    select

        try_to_number(feedback_id)                       as feedback_id,
        try_to_number(ticket_id)                          as ticket_id,
        try_to_date(feedback_date)                        as feedback_date,
        try_to_number(overall_rating)                     as overall_rating,

        case
            when upper(trim(felt_scared)) = 'TRUE' then true
            when upper(trim(felt_scared)) = 'FALSE' then false
            else null
        end                                                as felt_scared,

        case
            when upper(trim(worth_the_price)) = 'TRUE' then true
            when upper(trim(worth_the_price)) = 'FALSE' then false
            else null
        end                                                as worth_the_price,

        case
            when upper(trim(would_recommend)) = 'TRUE' then true
            when upper(trim(would_recommend)) = 'FALSE' then false
            else null
        end                                                as would_recommend,

        try_to_number(houses_visited)                     as houses_visited,
        try_to_number(house_1_rating)                      as house_1_rating,
        try_to_number(house_2_rating)                      as house_2_rating,
        try_to_number(house_3_rating)                      as house_3_rating,
        try_to_number(house_4_rating)                      as house_4_rating,
        try_to_number(house_5_rating)                      as house_5_rating,
        try_to_number(house_6_rating)                      as house_6_rating,
        try_to_number(house_7_rating)                      as house_7_rating,
        try_to_number(house_8_rating)                      as house_8_rating,
        try_to_number(house_9_rating)                      as house_9_rating,
        try_to_number(house_10_rating)                     as house_10_rating,
        trim(comments)                                     as comments,
        try_to_timestamp_ntz(created_at)                   as created_at,
        try_to_timestamp_ntz(updated_at)                   as updated_at

    from source

)

select * from renamed
