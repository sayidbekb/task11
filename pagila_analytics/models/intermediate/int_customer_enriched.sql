with customers as (
    select *
    from {{ ref('stg_customer') }}
),
addresses as (
    select address_id, address, district, city_id
    from {{ ref('stg_address') }}
),
cities as (
    select city_id, city
    from {{ ref('stg_city') }}
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    a.district,
    ci.city,
    c.create_date
from customers c
left join addresses a on c.address_id = a.address_id
left join cities ci on a.city_id = ci.city_id