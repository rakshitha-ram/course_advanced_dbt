{% macro rolling_aggregate(column_name, partition_by, aggregate_function, periods,order_by='created_date') %}



    {{ aggregate_function }}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ periods - 1 }} PRECEDING AND CURRENT ROW
            ) AS {{ aggregate_function }}_{{ periods }}_periods_{{ column_name }}


{% endmacro %}
