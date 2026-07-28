select
    ticket_id,
    ticket_type_name,
    description,
    price,
    includes_fast_pass as fast_pass_flag,
    includes_vip_benefits as vip_flag

from {{ ref('ticket_types') }}
