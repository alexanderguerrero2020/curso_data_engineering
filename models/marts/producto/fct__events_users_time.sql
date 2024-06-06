{% set event_types = ["checkout", "package_shipped", "add_to_cart","page_view"] %}
with

src_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__EVENTS') }}
),

src_users AS (
    SELECT *
    FROM  {{ ref('stg_sql_server_dbo__USERS') }}
),

src_events_users AS (
    SELECT *
    FROM {{ ref('int__events_users') }}
),

renamed as (
    select 
        C.SESSION_ID, 
        A.USER_ID, 
        MIN(C.CREATED_DATE) as FIRST_EVENT_TIME_UTC, 
        MAX(C.CREATED_DATE) as LAST_EVENT_TIME_UTC, 
        DATEDIFF(minute, FIRST_EVENT_TIME_UTC, LAST_EVENT_TIME_UTC) as SESSION_LENGHT_MINUTES,
        B.FIRST_NAME,
        B.EMAIL,
        A.CHECKOUT_AMOUNT,
        A.PACKAGE_SHIPPED_AMOUNT,
	    A.ADD_TO_CART_AMOUNT,
	    A.PAGE_VIEW_AMOUNT
    from src_events_users A
    JOIN src_users B
    ON A.user_id = B.user_id
    JOIN src_events C
    ON A.user_id = C.user_id
     GROUP BY session_id, A.user_id, first_name, last_name, email, A.CHECKOUT_AMOUNT,
        A.PACKAGE_SHIPPED_AMOUNT,
	    A.ADD_TO_CART_AMOUNT,
	    A.PAGE_VIEW_AMOUNT
)


SELECT * FROM renamed