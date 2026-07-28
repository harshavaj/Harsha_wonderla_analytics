with source as (

    select * from {{ source('park_internal', 'safety_incidents') }}

),

renamed as (

    select

        try_to_number(incident_id)                    as incident_id,
        try_to_number(haunted_house_id)                as ride_id,
        try_to_number(involved_haunted_house_id)       as involved_ride_id,
        try_to_date(incident_date)                     as incident_date,
        trim(incident_time)                            as incident_time,
        trim(incident_type)                            as incident_type,
        trim(severity_level)                           as severity_level,
        trim(description)                              as description,

        case
            when upper(trim(resolved)) = 'TRUE' then true
            when upper(trim(resolved)) = 'FALSE' then false
            else null
        end                                              as resolved,

        try_to_decimal(resolution_time_hours, 8, 2)    as resolution_time_hours,

        case
            when upper(trim(insurance_claim_filed)) = 'TRUE' then true
            when upper(trim(insurance_claim_filed)) = 'FALSE' then false
            else null
        end                                              as insurance_claim_filed,

        case
            when upper(trim(requires_follow_up)) = 'TRUE' then true
            when upper(trim(requires_follow_up)) = 'FALSE' then false
            else null
        end                                              as requires_follow_up,

        trim(actor_id_involved)                        as actor_id_involved,
        trim(action_taken)                              as action_taken,
        trim(reported_by)                               as reported_by,
        try_to_timestamp_ntz(created_at)               as created_at,
        try_to_timestamp_ntz(updated_at)               as updated_at

    from source

)

select * from renamed