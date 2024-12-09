
WITH hourly_weather_data AS (
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', timestamp) AS hour,
        AVG(precipitation) AS avg_precipitation,
        AVG(wind_speed) AS avg_wind_speed
    FROM hourly_weather
    WHERE timestamp BETWEEN '2023-09-25 00:00:00' AND '2023-10-03 23:59:59'
    GROUP BY STRFTIME('%Y-%m-%d %H:00:00', timestamp)
),
hourly_rides_data AS (
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', tpep_pickup_datetime) AS hour,
        COUNT(*) AS total_rides
    FROM taxi_trips
    WHERE tpep_pickup_datetime BETWEEN '2023-09-25 00:00:00' AND '2023-10-03 23:59:59'
    GROUP BY STRFTIME('%Y-%m-%d %H:00:00', tpep_pickup_datetime)
    UNION ALL
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', pickup_datetime) AS hour,
        COUNT(*) AS total_rides
    FROM uber_trips
    WHERE pickup_datetime BETWEEN '2023-09-25 00:00:00' AND '2023-10-03 23:59:59'
    GROUP BY STRFTIME('%Y-%m-%d %H:00:00', pickup_datetime)
),
all_hours AS (
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', DATETIME('2023-09-25 00:00:00', '+' || (a.n * 24 + b.n) || ' hours')) AS hour
    FROM (
        SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL 
        SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    ) a,
    (
        SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL 
        SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL 
        SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL 
        SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23
    ) b
    WHERE DATETIME('2023-09-25 00:00:00', '+' || (a.n * 24 + b.n) || ' hours') <= '2023-10-03 23:59:59'
)
SELECT 
    h.hour,
    COALESCE(r.total_rides, 0) AS total_hired_rides,
    COALESCE(w.avg_precipitation, 0) AS total_precipitation,
    COALESCE(w.avg_wind_speed, 0) AS avg_wind_speed
FROM all_hours h
LEFT JOIN hourly_rides_data r ON h.hour = r.hour
LEFT JOIN hourly_weather_data w ON h.hour = w.hour
ORDER BY h.hour ASC;
