{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__EVENTS') }}
    
    ),

renamed_casted AS (
    SELECT
        EVENT_ID
        , PAGE_URL
        , md5(EVENT_TYPE) as EVENT_TYPE_ID
        , USER_ID
        , CASE 
            WHEN product_id = '' THEN md5('sin_producto')
            ELSE product_id 
          END as product_id
        , SESSION_ID
        , created_date
        , CASE 
            WHEN ORDER_ID = '' THEN md5('sin_orden')
            ELSE ORDER_ID 
          END as ORDER_ID
        , deleted
        , utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted