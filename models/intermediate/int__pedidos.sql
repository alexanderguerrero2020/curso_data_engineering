with 

src_orders as (
    
    select * from {{ ref('stg_sql_server_dbo__ORDERS') }}

    
    
),

src_order_items as(

    select * from {{ ref('stg_sql_server_dbo__ORDER_ITEMS') }}

),

src_products as(

    select * from {{ ref('stg_sql_server_dbo__PRODUCTS') }}

),

src_promos as(
    select * from {{ ref('stg_sql_server_dbo__PROMOS') }}
),

renamed as (
    select 
        A.order_id,
        B.product_id,
        B.quantity as quantity,
        C.price,
        (B.quantity * C.price) as precio_productos,
        shipping_service_id,
        shipping_cost / COUNT(A.order_id) OVER(PARTITION by A.order_id ORDER by A.order_id) as shipping_cost_product, -- dividirlo entre el numero de pedidos
        address_id,
        utc_created_date,
        month,
        A.promo_id,
        D.discount_dolares / COUNT(A.order_id) OVER(PARTITION by A.order_id ORDER by A.order_id) as discount_dolares_product,
        utc_estimated_delivery_date,
        order_cost,
        user_id,
        (precio_productos + shipping_cost_product - discount_dolares_product) as precio_producto_total,
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
    JOIN 
        src_products C
    ON B.product_id = C.product_id
    JOIN 
        src_promos D
    ON
        A.promo_id = D.promo_id
    ORDER by order_id
)

select * from renamed
