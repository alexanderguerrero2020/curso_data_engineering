{{
  config(
    materialized='view'
  )
}}

with 

source as (

    select shipping_service_id from {{ ref('base_sql_server_dbo__ORDERS') }}

),

renamed as (

    select
        distinct(md5(shipping_service_id)) as shipping_service_id,
        IFF(shipping_service_id='', 'sin_shipping_service', shipping_service_id) as shipping_service_name
        
        
    from source
    
    

)

select * from renamed