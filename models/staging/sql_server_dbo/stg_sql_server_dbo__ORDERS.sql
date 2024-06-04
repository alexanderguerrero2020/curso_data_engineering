{{
  config(
    materialized='view'
  )
}}

with 

src_orders as (

    select * from {{ ref('base_sql_server_dbo__ORDERS') }}
),

renamed as (
    select
        order_id,
        md5(shipping_service_id) AS shipping_service_id,
        shipping_cost,
        address_id,
        utc_created_date,
        utc_created_date::DATE as month,
        CASE 
            WHEN promo_id = '' THEN md5('sin_promo') 
            ELSE md5(promo_id)
        END as promo_id,
        utc_estimated_delivery_date,
        order_cost,
        user_id,
        order_total,
        utc_delivered_date,
        CASE 
            WHEN tracking_id = '' THEN md5('sin_tracking')
            ELSE tracking_id
        END as tracking_id,
        md5(status_order_id) as status_order_id,
        deleted,
        utc_date_load

    from src_orders
    -- union all 
    -- select
    --     md5('sin_orden'),
    --     'd41d8cd98f00b204e9800998ecf8427e',
    --     0,
    --     null,
    --     null,
    --     null,
    --     md5('sin_promo'),
    --     null,
    --     0,
    --     null,
    --     0,
    --     null,
    --     md5('sin_tracking'),
    --     md5('sin_status_orden'),
    --     null,
    --     null
)

select * from renamed
