{{
config(
    materialized='view'
  )
}}

with 

src_promos as (

    select * from {{ source('sql_server_dbo', 'PROMOS') }}
    WHERE _fivetran_deleted IS NULL

),

renamed as (

    select
        md5(promo_id) as promo_id,
        promo_id as promo_name,
        discount as discount_dolares,
        IFF(status = 'active', '1', '0') as status_promo_id,
        CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load

    from src_promos 
    union all
    select
        md5('desconocido'),
        'desconocido',
        0,
        0,
        null

    )

select * from renamed


