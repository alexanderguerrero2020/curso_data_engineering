{{
  config(
    materialized='view'
  )
}}

with 

src_addresses as (

    select * from {{ source('sql_server_dbo', 'ADDRESSES') }}
    WHERE _fivetran_deleted IS NULL
),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load

    from src_addresses

)

select * from renamed
