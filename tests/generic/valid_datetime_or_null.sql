{% test valid_datetime_or_null(model, column_name) %}

    select *
    from {{ model }}
    where (
        to_char({{ column_name }}, 'YYYY-MM-DD HH24:MI:SS') IS NULL
        AND {{ column_name }} IS NOT NULL
    )

{% endtest %}