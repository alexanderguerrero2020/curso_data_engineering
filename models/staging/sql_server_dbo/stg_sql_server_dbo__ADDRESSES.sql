{{
  config(
    materialized='view'
  )
}}

with 

src_addresses as (

    select * from {{ source('sql_server_dbo', 'ADDRESSES') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted AS date_delete,
        _fivetran_synced AS date_load

    from src_addresses

)

select * from renamed
