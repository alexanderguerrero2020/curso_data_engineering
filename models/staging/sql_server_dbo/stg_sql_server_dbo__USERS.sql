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
        {{ convert_to_utc('updated_at')}} as updated_date,
        address_id,
        last_name,
        {{ convert_to_utc('created_at')}} as created_date,
        phone_number,
        total_orders,
        first_name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        {{ convert_to_utc('_fivetran_synced')}} as utc_date_load
    from src_users

)

select * from renamed
