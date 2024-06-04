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
        , CASE 
            WHEN product_id = '' THEN md5('sin_producto')
            ELSE product_id 
          END as product_id
        , SESSION_ID
        , {{ convert_to_utc('CREATED_AT')}} as created_date
        , CASE 
            WHEN ORDER_ID = '' THEN md5('sin_orden')
            ELSE ORDER_ID 
          END as ORDER_ID
        , _FIVETRAN_DELETED as deleted
        , {{ convert_to_utc('_fivetran_synced')}} as utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted