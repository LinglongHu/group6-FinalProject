
WITH daily_rides AS (
    -- Taxi trips
    SELECT 
        DATE(tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_distance) AS avg_trip_distance
    FROM taxi_trips
    WHERE STRFTIME('%Y', tpep_pickup_datetime) = '2023'
    GROUP BY ride_date
    UNION ALL
    -- Uber trips
    SELECT 
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_miles) AS avg_trip_distance
    FROM uber_trips
    WHERE STRFTIME('%Y', pickup_datetime) = '2023'
    GROUP BY ride_date
),
busiest_days AS (
    SELECT 
        ride_date,
        SUM(total_rides) AS total_rides,
        AVG(avg_trip_distance) AS avg_trip_distance
    FROM daily_rides
    GROUP BY ride_date
    ORDER BY total_rides DESC
    LIMIT 10
)
SELECT 
    b.ride_date,
    b.total_rides,
    b.avg_trip_distance,
    AVG(w.precipitation) AS avg_precipitation,
    AVG(w.wind_speed) AS avg_wind_speed
FROM busiest_days b
LEFT JOIN hourly_weather w 
ON b.ride_date = DATE(w.timestamp)
GROUP BY b.ride_date
ORDER BY b.total_rides DESC;
