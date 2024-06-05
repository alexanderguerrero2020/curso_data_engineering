{{
  config(
    materialized='table'
  )
}}


with 

src_order_items as (

    select * from {{ ref('stg_sql_server_dbo__ORDER_ITEMS') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        utc_date_load

    from src_order_items

)

select * from renamed
