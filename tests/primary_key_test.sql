{% test primary_key_test(model, column_name) %}
    select
      {{column_name}},
      count(*) as nb
    from {{ model }}
    group by {{ column_name }}
    having count(*) >= 2
{% endtest %}