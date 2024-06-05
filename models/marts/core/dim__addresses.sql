with 

src_addresses as (

    select * from {{ ref('stg_sql_server_dbo__ADDRESSES') }}

    -- {% if is_incremental() %}

	--   WHERE utc_date_load < (SELECT MAX(utc_date_load) FROM {{ this }} )

    -- {% endif %}
),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        utc_date_load

    from src_addresses

)

select * from renamed
