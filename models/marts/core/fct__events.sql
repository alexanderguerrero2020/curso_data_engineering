WITH src_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__EVENTS') }}
    
    ),

renamed_casted AS (
    SELECT
        EVENT_ID
        , PAGE_URL
        , EVENT_TYPE_ID
        , USER_ID
        , product_id
        , SESSION_ID
        , created_date
        , ORDER_ID
        , deleted
        , utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted