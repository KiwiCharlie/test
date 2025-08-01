SELECT
    tripduration,
    starttime AS trip_start_timestamp,
    stoptime AS trip_end_timestamp,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    bikeid,
    user_type,
    birth_year,
    gender
FROM
    {{ source('raw', 'citibike_raw') }}

