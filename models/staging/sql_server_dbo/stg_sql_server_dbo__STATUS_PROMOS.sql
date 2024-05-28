{{
  config(
    materialized='view'
  )
}}

with 

source as (

    select status from {{ source('sql_server_dbo', 'PROMOS') }}

),

renamed as (

    select
        distinct(status) as status_promo_name,
        IFF(status = 'active', '1', '0') as status_promo_id

    from source

)

select * from renamed
