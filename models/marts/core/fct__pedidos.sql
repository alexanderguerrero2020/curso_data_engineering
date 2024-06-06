with 

src_pedidos as (
    
    select * from {{ ref('int__pedidos') }}

),

renamed as (
    
    select 
        order_id,
        product_id,
        quantity,
        price,
        precio_productos,
        shipping_service_id,
        shipping_cost_product, 
        address_id,
        utc_created_date,
        month,
        promo_id,
        discount_dolares_product,
        utc_estimated_delivery_date,
        order_cost,
        user_id,
        ROUND(precio_producto_total) as precio_producto_total,
        order_total,
        utc_delivered_date,
        tracking_id,
        status_order_id,
        utc_date_load 
    FROM src_pedidos
)

select * from renamed
