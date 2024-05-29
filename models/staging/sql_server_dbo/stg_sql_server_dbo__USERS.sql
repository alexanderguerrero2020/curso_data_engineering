{{
  config(
    materialized='view'
  )
}}

with 

src_users as (

    select * from {{ source('sql_server_dbo', 'USERS') }}
    WHERE _fivetran_deleted IS NULL

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
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load
    from src_users

)

select * from renamed
