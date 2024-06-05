with 
source as (

    select * from {{ ref('stg_sql_server_dbo__STATUS_PROMOS') }}

),

renamed as (

    select
        status_promo_id,
        status_promo_name

    from source

)

select * from renamed
