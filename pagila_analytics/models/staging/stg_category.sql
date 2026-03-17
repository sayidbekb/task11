SELECT
    category_id,
    name as category_name,
    last_update
FROM {{ source('pagila', 'category')}}