{{
  config(
    materialized='table'
  )
}}

with 

src_products as (

    select * from {{ ref('stg_sql_server_dbo__PRODUCTS') }}

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        utc_date_load

    from src_products
)

select * from renamed
