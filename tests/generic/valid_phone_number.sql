{% test valid_phone_number(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} IS NULL
       or {{ column_name }} !~ '^\d{3}-\d{3}-\d{4}$'

{% endtest %}