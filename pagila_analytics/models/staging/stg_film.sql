SELECT
    film_id,
    title,
    description,
    cast(release_year as integer) as release_year, 
    language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    rating,
    last_update
FROM {{ source('pagila', 'film') }}