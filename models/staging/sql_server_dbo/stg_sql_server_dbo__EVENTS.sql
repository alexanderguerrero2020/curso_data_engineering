{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'EVENTS') }}
    WHERE _fivetran_deleted IS NULL
    ),

renamed_casted AS (
    SELECT
        EVENT_ID
        , PAGE_URL
        , EVENT_TYPE
        , USER_ID
        , PRODUCT_ID
        , SESSION_ID
        , CREATED_AT
        , ORDER_ID
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_fivetran_synced)) as utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted