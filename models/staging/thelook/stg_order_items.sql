with source as (

    select * from {{ ref('raw_order_items') }}

)

select
    id as order_item_id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    status as order_item_status,
    cast(created_at as timestamp) as order_item_created_at,
    cast(shipped_at as timestamp) as shipped_at,
    cast(delivered_at as timestamp) as delivered_at,
    cast(returned_at as timestamp) as returned_at,
    cast(sale_price as numeric) as sale_price
from source
