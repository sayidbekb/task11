SELECT
    inventory_id,
    film_id,
    store_id,
    last_update
FROM {{ source('pagila', 'inventory') }}