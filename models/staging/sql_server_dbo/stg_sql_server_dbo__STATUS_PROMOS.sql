{{
  config(
    materialized='view'
  )
}}

with 
source as (

    select status_promo_id from {{ ref('stg_sql_server_dbo__PROMOS') }}

),

renamed as (

    select
        distinct(status_promo_id) as status_promo_id,
        IFF(status_promo_id = '1', 'active', 'inactive') as status_promo_name

    from source

)

select * from renamed
