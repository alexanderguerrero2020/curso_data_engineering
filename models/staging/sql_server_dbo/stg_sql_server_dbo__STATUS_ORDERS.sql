{{
  config(
    materialized='view'
  )
}}

with 
source as (

    select status_order_id from {{ ref('base_sql_server_dbo__ORDERS') }}

),

renamed as (

    select
        distinct(md5(status_order_id)) as status_order_id,
        IFF(status_order_id='','sin_status_orden',status_order_id) as status_order_name
    from source
)

select * from renamed
