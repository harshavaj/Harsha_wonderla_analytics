-- generate a list of dates so we can join other tables to it later
with date_spine as (
    select dateadd(day, seq4(), '2023-01-01'::date) as date_day
    from table(generator(rowcount => 1461))
)

select
    date_day,
    year(date_day) as year,
    month(date_day) as month_number,
    monthname(date_day) as month_name,
    quarter(date_day) as quarter,

    -- weekend check
    case
        when dayofweek(date_day) in (0, 6) then true
        else false
    end as is_weekend

from date_spine