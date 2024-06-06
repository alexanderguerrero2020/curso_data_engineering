{% set event_types = ["checkout", "package_shipped", "add_to_cart","page_view"] %}
WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__EVENTS') }}
),

renamed_casted AS (
    SELECT
        user_id,
        {%- for EVENT_TYPE_NAME in event_types   %}
        sum(case when EVENT_TYPE_NAME = '{{EVENT_TYPE_NAME}}' then 1 end) as {{EVENT_TYPE_NAME}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
    FROM stg_events
    GROUP BY 1
    )

SELECT * FROM renamed_casted