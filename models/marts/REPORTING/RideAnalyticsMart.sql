with maintenance_by_ride as (
    select ride_id, sum(maintenance_cost) as maintenance_cost
    from {{ ref('maintenance_costs') }}
    group by ride_id
),
checkins_by_ride as (
    select ride_id, count(*) as checkin_count
    from {{ ref('checkins') }}
    group by ride_id
)
select
    r.ride_id,
    r.ride_name,
    r.thrill_level,
    coalesce(m.maintenance_cost, 0) as maintenance_cost,
    coalesce(c.checkin_count, 0) as checkin_count
from {{ ref('stgrides') }} r
left join maintenance_by_ride m on r.ride_id = m.ride_id
left join checkins_by_ride c on r.ride_id = c.ride_id
