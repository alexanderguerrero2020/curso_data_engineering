-- Da error porque he creado una orden nueva que me la he seteado en null.
SELECT *
FROM {{ ref('stg_sql_server_dbo__ORDERS') }}
WHERE delivered_at < created_at
/* comprueba si hay algún caso en el que la fecha de entrega sea anterior a la fecha en que se realizó el pedido, lo que no tendría sentido lógico e indicaría algún tipo de problema con los datos */