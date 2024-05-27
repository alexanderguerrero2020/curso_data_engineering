{{
  config(
    materialized='view'
  )
}}

with 

src_products as (

    select * from {{ source('sql_server_dbo', 'PRODUCTS') }}

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted AS date_delete,
        _fivetran_synced AS date_load

    from src_products

)

select * from renamed
