-- También acepta valores vacíos
{% test accepted_values(model, column_name, values) %}

   select *
   from {{ model }}
   where {{ column_name }} NOT IN ({{ values | join(', ') }})
   and {{ column_name }} IS NOT NULL
   and {{ column_name }} <> ''

{% endtest %}