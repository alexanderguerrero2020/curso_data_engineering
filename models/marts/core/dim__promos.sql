{{
config(
    materialized='table'
  )
}}

with 

src_promos as (

    select * from {{ ref('stg_sql_server_dbo__PROMOS') }}
    

),

renamed as (

    select
        promo_id,
        promo_name,
        discount_dolares,
        status_promo_id,
        utc_date_load

    from src_promos 

    )

select * from renamed


