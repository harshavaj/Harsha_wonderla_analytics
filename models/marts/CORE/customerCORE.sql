select
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    age,
    gender,
    is_vip_member,
    loyalty_points,
    registration_date,

    -- loyalty tier based on points
    case
        when loyalty_points >= 5000 then 'Platinum'
        when loyalty_points >= 2000 then 'Gold'
        when loyalty_points >= 500 then 'Silver'
        else 'Bronze'
    end as loyalty_tier,

    -- age group
    case
        when age < 13 then 'Child'
        when age < 20 then 'Teen'
        when age < 36 then 'Young Adult'
        when age < 56 then 'Adult'
        else 'Senior'
    end as age_group

from {{ ref('stg_customer') }}
