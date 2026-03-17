select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    a.district,
    ci.city,
    ci.country_id,
    c.active,
    c.create_date
from {{ ref('stg_customer') }} as c
left join {{ ref('stg_address') }} as a
    on c.address_id = a.address_id
left join {{ ref('stg_city') }} as ci
    on a.city_id = ci.city_id