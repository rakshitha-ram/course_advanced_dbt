WITH

events AS (
    SELECT
        user_id,
        DATE(created_at) AS created_date,
        event_id AS login_id
    FROM
        {{ ref('stg_bingeflix__events')}}
    WHERE
        event_name = 'User Logged In'
),

date_spine AS (
    SELECT
        calendar_date,
        date_week
    FROM
        {{ ref('int_dates')}}
),

final AS (
    SELECT
        created_date,
        {{ dbt_utils.generate_surrogate_key(['date_week', 'user_id']) }} AS surrogate_key,
        date_week,
        user_id,
        COUNT(DISTINCT login_id) AS login_count
    FROM
        date_spine
        LEFT JOIN events ON date_spine.calendar_date = events.created_date
    GROUP BY ALL
)

SELECT *,
{{rolling_average_7_periods(column_name ='login_count', partition_by='user_id')}} as macro_test,
{{rolling_aggregate(column_name='login_count', partition_by='user_id', aggregate_function='sum', periods=30)}} as macro_test_2

    FROM final
