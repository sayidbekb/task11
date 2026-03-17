select
    p.payment_id,
    p.payment_date,
    p.customer_id,
    r.rental_id,
    i.film_id,
    f.title as film_title,
    p.amount as revenue
from {{ ref('stg_payment') }} p
left join {{ ref('stg_rental') }} r
    on p.rental_id = r.rental_id
left join {{ ref('stg_inventory') }} i
    on r.inventory_id = i.inventory_id
left join {{ ref('stg_film') }} f
    on i.film_id = f.film_id