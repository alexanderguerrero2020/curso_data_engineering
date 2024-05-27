{{
  config(
    materialized='view'
  )
}}

with 

src_promos as (

    select * from {{ source('sql_server_dbo', 'PROMOS') }}

),

renamed as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted AS date_delete,
        _fivetran_synced AS date_load

    from src_promos

)

select * from renamed
