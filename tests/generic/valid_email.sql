{% test valid_email(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} IS NULL
       or {{ column_name }} != '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

{% endtest %}