with order_items as (

    select * from {{ ref('stg_order_items') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

products as (

    select * from {{ ref('stg_products') }}

)

select
    order_items.order_item_id,
    order_items.order_id,
    order_items.user_id,
    order_items.product_id,
    products.product_name,
    products.category as product_category,
    products.department,
    orders.order_status,
    order_items.order_item_status,
    orders.order_created_at,
    cast(orders.order_created_at as date) as order_date,
    order_items.sale_price,
    products.cost as product_cost,
    order_items.sale_price - products.cost as gross_margin
from order_items
inner join orders
    on order_items.order_id = orders.order_id
inner join products
    on order_items.product_id = products.product_id
