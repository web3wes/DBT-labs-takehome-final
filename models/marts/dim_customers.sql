with users as (

    select * from {{ ref('stg_users') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

customer_orders as (

    select
        user_id,
        min(order_created_at) as first_order_at,
        max(order_created_at) as most_recent_order_at,
        count(distinct order_id) as lifetime_order_count
    from orders
    where order_status = 'Complete'
    group by 1

)

select
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.age,
    users.gender,
    users.city,
    users.state,
    users.country,
    users.traffic_source,
    users.user_created_at,
    customer_orders.first_order_at,
    customer_orders.most_recent_order_at,
    coalesce(customer_orders.lifetime_order_count, 0) as lifetime_order_count
from users
left join customer_orders
    on users.user_id = customer_orders.user_id
