{% macro int_ord_revenue(extend,discount) %}
  {{extend}} * (1-{{discount}})
{% endmacro %}