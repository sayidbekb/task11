select
    a.actor_id,
    a.first_name,
    a.last_name,
    count(r.rental_id) as rentals_count
from {{ ref('int_film_actor_bridge') }} fa
join {{ ref('int_rental_facts') }} r
    on fa.film_id = r.film_id
join {{ ref('dim_actor') }} a
    on fa.actor_id = a.actor_id
join {{ ref('dim_film') }} f
    on fa.film_id = f.film_id
where f.rating in ('G', 'PG')
group by a.actor_id, a.first_name, a.last_name
order by rentals_count desc