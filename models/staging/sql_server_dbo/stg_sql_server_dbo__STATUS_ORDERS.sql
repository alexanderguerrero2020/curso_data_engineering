{{
  config(
    materialized='view'
  )
}}

with 
source as (

    select status from {{ source('sql_server_dbo', 'ORDERS') }}

),

renamed as (

    select
        distinct(md5(status)) as status_order_id,
        status as status_order_name
    from source
)

select * from renamed
