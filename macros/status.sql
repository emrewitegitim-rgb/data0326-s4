{% macro getStatus(date_shipping, date_delivery, date_cancelled) %}
    CASE
        WHEN date_cancelled IS NOT NULL THEN 'Cancelled'
        WHEN date_shipping IS NULL THEN 'In progress'
        WHEN date_delivery IS NULL THEN 'Shipped'
        WHEN date_delivery IS NOT NULL THEN 'Delivered'
        ELSE NULL
    END
{% endmacro %}