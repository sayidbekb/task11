select
    city,
    count(customer_id) as total_customers
from {{ ref('dim_customer') }}
group by city
order by total_customers desc