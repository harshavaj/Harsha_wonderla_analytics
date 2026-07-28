{% snapshot ticket_types_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='ticket_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('park_assets', 'ticket_types') }}

{% endsnapshot %}