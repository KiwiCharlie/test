WITH daily_trips AS (
    -- Aggregate citibike trips by day
    SELECT
        DATE(trip_start_timestamp) AS trip_date,
        COUNT(*) AS daily_total_rides,
        SUM(tripduration) AS daily_total_duration_sec,
        COUNT(DISTINCT bikeid) AS daily_unique_bikes
    FROM
        {{ ref('stg_citibike_trips') }}
    GROUP BY 1
),

daily_weather_summary AS (
    -- Aggregate weather data by day, calculating min/max/avg
    SELECT
        DATE(observation_time) AS weather_date,
        MIN(temp_fahrenheit) AS min_temp_f,
        MAX(temp_fahrenheit) AS max_temp_f,
        AVG(temp_fahrenheit) AS avg_temp_f,
        MAX(CASE WHEN weather_main IN ('Rain', 'Drizzle', 'Thunderstorm') THEN TRUE ELSE FALSE END) AS is_rainy_day,
        MAX(CASE WHEN weather_main IN ('Snow', 'Blizzard') THEN TRUE ELSE FALSE END) AS is_snowy_day
    FROM
        {{ ref('stg_nyc_weather') }}
    GROUP BY 1
)

SELECT
    trips.trip_date,
    trips.daily_total_rides,
    trips.daily_total_duration_sec,
    trips.daily_unique_bikes,
    weather.min_temp_f,
    weather.max_temp_f,
    weather.avg_temp_f,
    weather.is_rainy_day,
    weather.is_snowy_day
FROM
    daily_trips AS trips
LEFT JOIN
    daily_weather_summary AS weather ON trips.trip_date = weather.weather_date
ORDER BY
    trips.trip_date

   