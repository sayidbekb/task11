SELECT
    fa.film_id,
    f.title,
    fa.actor_id,
    a.first_name,
    a.last_name
FROM {{ source('pagila', 'film_actor') }} fa
LEFT JOIN {{ ref('stg_actor')}} a
    ON fa.actor_id = a.actor_id
LEFT JOIN {{ ref("stg_film")}} f
    on fa.film_id = f.film_id