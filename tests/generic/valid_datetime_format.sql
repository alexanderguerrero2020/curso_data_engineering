{% test valid_datetime_format(model, column_name) %}

   select *
   from {{ model }}
   where to_char({{ column_name }}, 'YYYY-MM-DD HH24:MI:SS') IS NOT NULL

{% endtest %}