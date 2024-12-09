
WITH daily_snowfall AS (
    SELECT 
        DATE(date) AS snowfall_date,
        MAX(snowfall) AS total_snowfall
    FROM daily_weather
    WHERE date BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY DATE(date)
),
daily_rides AS (
    -- Taxi rides
    SELECT 
        DATE(tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM taxi_trips
    WHERE tpep_pickup_datetime BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY DATE(tpep_pickup_datetime)
    UNION ALL
    -- Uber rides
    SELECT 
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM uber_trips
    WHERE pickup_datetime BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY DATE(pickup_datetime)
),
snowy_rides AS (
    SELECT 
        s.snowfall_date,
        s.total_snowfall,
        COALESCE(SUM(r.total_rides), 0) AS total_hired_rides
    FROM daily_snowfall s
    LEFT JOIN daily_rides r 
        ON s.snowfall_date = r.ride_date
    GROUP BY s.snowfall_date, s.total_snowfall
    ORDER BY s.total_snowfall DESC
    LIMIT 10
)
SELECT 
    snowfall_date AS date,
    total_snowfall,
    total_hired_rides
FROM snowy_rides
ORDER BY total_snowfall DESC;
