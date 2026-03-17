select
    f.category_name,
    sum(datediff(hour, r.rental_date, r.return_date)) as total_rental_hours
from {{ ref('int_rental_facts') }} r
join {{ ref('dim_film') }} f
    on r.film_id = f.film_id
group by f.category_name
order by total_rental_hours desc