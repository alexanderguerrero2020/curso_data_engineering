{{ config(
    materialized='view',
   
    ) 
    }}


WITH stg_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets','budget') }}

-- {% if is_incremental() %}
    -- unique_key = '_row'
-- 	  WHERE _fivetran_synced < (SELECT MAX(_fivetran_synced) FROM {{ this }} )

-- {% endif %}
    ),

renamed_casted AS (
    SELECT
          _row
        , product_id
        , month
        , quantity 
        , _fivetran_synced
    FROM stg_budget_products
    )

SELECT * FROM renamed_casted