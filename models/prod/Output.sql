
    SELECT
        DATE(trip_start_timestamp) AS trip_date,
        COUNT(*) AS daily_total_rides,
        SUM(tripduration) AS daily_total_duration_sec,
        COUNT(DISTINCT bikeid) AS daily_unique_bikes
    FROM
        {{ ref('stg_citibike_trips') }}
    GROUP BY 1
