WITH

src_users as (

    SELECT * FROM {{ ref('stg_sql_server_dbo__USERS')  }}
),

src_pedidos as (

    SELECT * FROM {{ ref('int__pedidos')  }}

),

src_address as(

    SELECT * FROM {{ ref('stg_sql_server_dbo__ADDRESSES')  }}

),

renamed_casted AS (
    SELECT
        B.user_id,
        A.first_name,
        A.last_name,
        A.email,
        A.phone_number,
        A.created_date as created_date_utc,
        A.updated_date as updated_date_utc,
        C.address,
        C.zipcode,
        C.state,
        C.country,
        COUNT(distinct(B.order_id)) as total_number_orders,
        SUM(B.precio_producto_total) as total_order_cost_usd,
        SUM(B.discount_dolares_product) as total_discount_usd,
        SUM(B.quantity) as total_quantity_product,
        COUNT(B.order_id) as total_diff_products
    FROM src_users A
    JOIN src_pedidos B
    ON A.user_id = B.user_id
    JOIN src_address C
    ON A.address_id = C.address_id
    GROUP by B.user_id, A.first_name,
        A.last_name,
        A.email,
        A.phone_number,
        created_date_utc,
        updated_date_utc,
        C.address,
        C.zipcode,
        C.state,
        C.country
    )

SELECT * FROM renamed_casted