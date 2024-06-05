{{
  config(
    materialized='view'
  )
}}


with 

src_order_items as (

    select * from {{ source('sql_server_dbo', 'ORDER_ITEMS') }}
    WHERE _fivetran_deleted IS NULL

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        _FIVETRAN_DELETED as deleted,
        {{ convert_to_utc('_fivetran_synced')}} as utc_date_load

    from src_order_items

)

select * from renamed
