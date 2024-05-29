{{
  config(
    materialized='view'
  )
}}

with 

source as (

    select shipping_service from {{ source('sql_server_dbo', 'ORDERS') }}

),

renamed as (

    select
        distinct(md5(shipping_service)) AS shipping_service_id,
        CASE 
            WHEN shipping_service = '' THEN 'sin_shipping_service'
            ELSE shipping_service
        END as shipping_service_name
        
        
    from source
    
    

)

select * from renamed