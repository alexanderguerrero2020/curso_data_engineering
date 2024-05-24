{{
  config(
    materialized='view'
  )
}}

with 

src_users as (

    select * from {{ source('sql_server_dbo', 'USERS') }}

),

renamed as (

    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted AS date_delete,
        _fivetran_synced AS date_load

    from src_users

)

select * from renamed
