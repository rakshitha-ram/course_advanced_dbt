with monthly_subscriptions as (
    select
        subscription_id,
        user_id,
        starts_at,
        ends_at,
        plan_name,
        pricing,
        date(date_trunc('month', starts_at)) as start_month,
        date(date_trunc('month', ends_at)) as end_month
    from
        {{ ref('dim_subscriptions') }}
    where
        billing_period = 'monthly'
),

subscription_periods as (
    select
        subscription_id,
        user_id,
        plan_name,
        pricing as monthly_amount,
        starts_at,
        ends_at,
        start_month,
        -- For users that cancel in the first month, set their end_month to next month because the subscription remains active until the end of the first month
        -- For users who haven't ended their subscription yet (end_month is NULL) set the end_month to one month from the current date (these rows will be removed from the final CTE)
        case
            when start_month = end_month then dateadd('month', 1, end_month)
            when end_month is null then date(dateadd('month', 1, date_trunc('month', current_date)))
            else end_month
        end as end_month
    from
        monthly_subscriptions
)

select * from subscription_periods
