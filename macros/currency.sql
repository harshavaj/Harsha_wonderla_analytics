{% macro format_currency(column_name) %}
    round({{ column_name }}, 2)
{% endmacro %}
