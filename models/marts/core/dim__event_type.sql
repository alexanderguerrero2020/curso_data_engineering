{{
  config(
    materialized='table'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__EVENT_TYPE') }}
    
    ),

renamed_casted AS (
    SELECT
        EVENT_TYPE_ID,
        EVENT_TYPE_NAME
    FROM src_events
    )

SELECT * FROM renamed_casted