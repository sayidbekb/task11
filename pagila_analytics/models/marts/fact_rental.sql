select
    r.rental_id,
    r.rental_date,
    r.return_date,
    r.customer_id,
    r.inventory_id,
    i.film_id,
    f.title as film_title,
    p.amount as payment_amount
from {{ ref('stg_rental') }} r
left join {{ ref('stg_inventory') }} i
    on r.inventory_id = i.inventory_id
left join {{ ref('stg_film') }} f
    on i.film_id = f.film_id
left join {{ ref('stg_payment') }} p
    on r.rental_id = p.rental_id