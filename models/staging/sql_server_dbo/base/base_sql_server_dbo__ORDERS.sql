{{
  config(
    materialized='view'
  )
}}

with 

src_orders as (

    select * from {{ source('sql_server_dbo', 'ORDERS')  }}
),

renamed as (
    select
        order_id,
        shipping_service as shipping_service_id,
        shipping_cost,
        address_id,
        {{ convert_to_utc('created_at')}} as utc_created_date,
        promo_id,
        {{ convert_to_utc('estimated_delivery_at')}} as utc_estimated_delivery_date,
        order_cost,
        user_id,
        order_total,
        {{ convert_to_utc('delivered_at')}} as utc_delivered_date,
        tracking_id,
        status as status_order_id,
        _FIVETRAN_DELETED as deleted,
        {{ convert_to_utc('_fivetran_synced')}} as utc_date_load
    from src_orders
)

select * from renamed
