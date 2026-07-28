-- combine all cost tables into one operating expense fact table

with electricity as (
    select
        cost_id,
        ride_id,
        cost_date,
        electricity_cost as amount,
        'Electricity' as expense_category
    from {{ ref('electricity_costs') }}
),

maintenance as (
    select
        cost_id,
        ride_id,
        cost_date,
        maintenance_cost as amount,
        'Maintenance' as expense_category
    from {{ ref('maintenance_costs') }}
),

supplies as (
    select
        cost_id,
        ride_id,
        cost_date,
        supplies_cost as amount,
        'Supplies' as expense_category
    from {{ ref('supplies_costs') }}
),

staff as (
    select
        cost_id,
        ride_id,
        cost_date,
        staff_cost as amount,
        'Staff' as expense_category
    from {{ ref('staff_costs') }}
)

select * from electricity
union all
select * from maintenance
union all
select * from supplies
union all
select * from staff