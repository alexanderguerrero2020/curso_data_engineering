with 

src_orders as (
    
    select * from {{ ref('stg_sql_server_dbo__ORDERS') }}

    
    
),

src_order_items as(

    select * from {{ ref('stg_sql_server_dbo__ORDER_ITEMS') }}

),

renamed as (
    select 
        row_number() over(PARTITION BY A.order_id ORDER BY A.order_id) as transaction_line,
        A.order_id,
        B.product_id,
        B.quantity,
        shipping_service_id,
        shipping_cost,
        address_id,
        utc_created_date,
        month,
        promo_id,
        utc_estimated_delivery_date,
        order_cost,
        user_id,
        order_total,
        utc_delivered_date,
        tracking_id,
        status_order_id,
        A.utc_date_load
    from 
        src_orders A
    JOIN  
        src_order_items B
    ON A.order_id = B.order_id
)

select * from renamed
