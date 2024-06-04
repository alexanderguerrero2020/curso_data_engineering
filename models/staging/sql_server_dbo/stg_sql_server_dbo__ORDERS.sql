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
        {{ convert_to_utc('created_at')}} as created_date,
        CASE 
            WHEN promo_id = '' THEN md5('sin_promo') 
            ELSE md5(promo_id)
        END as promo_id,
        {{ convert_to_utc('estimated_delivery_at')}} as estimated_delivery_date,
        order_cost,
        user_id,
        order_total,
        {{ convert_to_utc('delivered_at')}} as delivered_date,
        CASE 
            WHEN tracking_id = '' THEN md5('sin_tracking')
            ELSE tracking_id
        END as tracking_id,
        md5(status) as status_order_id,
        _FIVETRAN_DELETED as deleted,
        {{ convert_to_utc('_fivetran_synced')}} as utc_date_load

    from src_orders
    union all 
    select
        md5('sin_orden'),
        'd41d8cd98f00b204e9800998ecf8427e',
        0,
        null,
        null,
        md5('sin_promo'),
        null,
        0,
        null,
        0,
        null,
        md5('sin_tracking'),
        md5('sin_status_orden'),
        null,
        null

)

select * from renamed
