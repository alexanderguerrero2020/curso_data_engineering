{{
    config(
        materialized = "table"
    )
}}
{{ dbt_date.get_date_dimension('2018-01-01', '2024-12-31') }}