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
        _fivetran_deleted,
        {{ convert_to_utc('_fivetran_synced')}} as utc_date_load

    from src_promos 
    union all
    select
        md5('sin_promo'),
        'sin promo',
        0,
        0,
        null,
        null

    )

select * from renamed


