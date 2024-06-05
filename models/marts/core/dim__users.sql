with 

src_users as (

    select * from {{ ref('stg_sql_server_dbo__USERS') }}


),

src_orders as (

    select * from {{ ref('stg_sql_server_dbo__ORDERS') }}

),

renamed as (

    SELECT 
    A.user_id,
    updated_date,
    A.address_id AS address_id,
    A.last_name AS last_name,
    A.created_date AS created_date,
    A.phone_number AS phone_number,
    COUNT(B.user_id) AS total_orders,
    A.first_name AS first_name,
    A.email AS email,
    A.utc_date_load AS utc_date_load
    FROM 
        src_users A
    LEFT JOIN 
        src_orders B
    ON 
        A.user_id = B.user_id
    GROUP BY A.user_id,
    updated_date,
    a.address_id,
    last_name,
    created_date,
    phone_number,
    first_name,
    email,
    a.utc_date_load
    ORDER by A.user_id
)

select * from renamed
