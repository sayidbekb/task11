select
    f.film_id,
    f.title,
    f.description,
    f.release_year,
    f.language_id,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    c.category_name
from {{ ref('stg_film') }} as f
left join {{ ref('stg_category') }} as c
    on f.film_id = c.category_id