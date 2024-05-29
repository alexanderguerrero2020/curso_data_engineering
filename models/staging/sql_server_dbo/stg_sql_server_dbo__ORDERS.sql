{{
  config(
    materialized='view'
  )
}}

with 

src_orders as (

    select * from {{ source('sql_server_dbo', 'ORDERS') }}
    WHERE _fivetran_deleted IS NULL
),

renamed as (

    select
        order_id,
        md5(shipping_service) AS shipping_service_id,
        shipping_cost,
        address_id,
        created_at,
        CASE 
            WHEN promo_id = '' THEN md5('desconocido') 
            ELSE md5(promo_id)
        END as promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        md5(status) as status_order_id,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load

    from src_orders
    

)

select * from renamed
