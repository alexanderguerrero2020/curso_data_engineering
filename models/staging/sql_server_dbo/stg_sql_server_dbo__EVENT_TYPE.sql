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
        distinct(md5(EVENT_TYPE)) as EVENT_TYPE_ID,
        EVENT_TYPE as EVENT_TYPE_NAME
    FROM src_events
    )

SELECT * FROM renamed_casted