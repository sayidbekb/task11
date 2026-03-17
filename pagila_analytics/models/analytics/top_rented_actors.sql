select
    a.actor_id,
    a.first_name,
    a.last_name,
    count(r.rental_id) as total_rentals
from {{ ref('int_film_actor_bridge') }} fa
join {{ ref('int_rental_facts') }} r
    on fa.film_id = r.film_id
join {{ ref('dim_actor') }} a
    on fa.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by total_rentals desc