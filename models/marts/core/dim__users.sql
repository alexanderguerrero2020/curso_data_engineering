{{
  config(
    materialized='view'
  )
}}

with 

src_users as (

    SELECT 
    A.user_id,
    ANY_VALUE(A.updated_date) AS updated_date,
    ANY_VALUE(A.address_id) AS address_id,
    ANY_VALUE(A.last_name) AS last_name,
    ANY_VALUE(A.created_date) AS created_date,
    ANY_VALUE(A.phone_number) AS phone_number,
    COUNT(B.user_id) AS total_orders,
    ANY_VALUE(A.first_name) AS first_name,
    ANY_VALUE(A.email) AS email,
    ANY_VALUE(A.utc_date_load) AS utc_date_load
    FROM 
        {{ ref('stg_sql_server_dbo__USERS') }} A
    LEFT JOIN 
        {{ ref('stg_sql_server_dbo__ORDERS') }} B
    ON 
        A.user_id = B.user_id
    GROUP BY 
        A.user_id
    ORDER BY 
        A.user_id


),

renamed as (

    select
        *
    from src_users

)

select * from renamed
