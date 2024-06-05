with 
source as (

    select * from {{ ref('stg_sql_server_dbo__STATUS_ORDERS') }}

),

renamed as (

    select
        status_order_id,
        status_order_name
    from source
)

select * from renamed
