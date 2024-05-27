{{
  config(
    materialized='view'
  )
}}


with 

src_order_items as (

    select * from {{ source('sql_server_dbo', 'ORDER_ITEMS') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted AS date_delete,
        _fivetran_synced AS date_load

    from src_order_items

)

select * from renamed
