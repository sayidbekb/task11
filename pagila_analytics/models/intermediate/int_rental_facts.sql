SELECT
    r.rental_id,
    r.rental_date,
    r.return_date,
    r.customer_id,
    i.film_id,
    f.title,
    p.amount,
    p.payment_date
FROM {{ ref('stg_rental')}} r
LEFT JOIN {{ ref('stg_inventory')}} i
    ON r.inventory_id = i.inventory_id
LEFT JOIN {{ ref('stg_film')}} f
    ON i.film_id = f.film_id
LEFT JOIN {{ ref('stg_payment')}} p
    ON r.rental_id = p.rental_id
