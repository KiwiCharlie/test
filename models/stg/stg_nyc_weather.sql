SELECT
    v:"time"::TIMESTAMP AS observation_time,
    v:"city"."id"::INT AS city_id,
    v:"city"."name"::STRING AS city_name,
    v:"main"."temp"::FLOAT AS temp_kelvin,
    (v:"main"."temp"::FLOAT - 273.15) AS temp_celsius,
    (v:"main"."temp"::FLOAT * 9/5 - 459.67) AS temp_fahrenheit,
    v:"weather"[0]."main"::STRING AS weather_main,
    v:"wind"."speed"::FLOAT AS wind_speed,
    v:"weather"[0]."id"::INT AS weather_id
FROM
    {{ source('raw', 'nyc_weather') }}
WHERE
    city_id = 5128638 -- Filter for NYC