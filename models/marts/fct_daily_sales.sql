with order_items as (

    select * from {{ ref('int_order_items_enriched') }}
    where order_item_status = 'Complete'

)

select
    order_date,
    product_category,
    department,
    count(distinct order_id) as order_count,
    count(distinct user_id) as customer_count,
    count(*) as item_count,
    sum(sale_price) as gross_revenue,
    sum(gross_margin) as gross_margin,
    sum(sale_price) / nullif(count(distinct order_id), 0) as average_order_value
from order_items
group by 1, 2, 3
