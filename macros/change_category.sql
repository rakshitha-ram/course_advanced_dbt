{% macro calculate_change_category(is_first_subscription_month, is_subscribed_current_month, is_subscribed_previous_month, mrr_change) %}
    CASE
        WHEN {{ is_first_subscription_month }} THEN 'new'
        WHEN NOT({{ is_subscribed_current_month }}) AND {{ is_subscribed_previous_month }} THEN 'churn'
        WHEN {{ is_subscribed_current_month }} AND NOT({{ is_subscribed_previous_month }}) THEN 'reactivation'
        WHEN {{ mrr_change }} > 0.0 THEN 'upgrade'
        WHEN {{ mrr_change }} < 0.0 THEN 'downgrade'
        ELSE 'renewal'
    END
{% endmacro %}
