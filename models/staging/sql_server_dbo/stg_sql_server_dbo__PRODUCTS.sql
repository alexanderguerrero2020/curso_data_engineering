{{
  config(
    materialized='view'
  )
}}

with 

src_products as (

    select * from {{ source('sql_server_dbo', 'PRODUCTS') }}
    WHERE _fivetran_deleted IS NULL

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load

    from src_products

)

select * from renamed
