select
    weather_id,
    weather_date,
    season,
    weather_type,
    temperature_c,
    rainfall_mm,
    is_park_open,

    case
        when is_park_open then 'Open'
        else 'Closed'
    end as park_status

from {{ ref('weather_data') }}