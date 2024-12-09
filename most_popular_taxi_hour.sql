
SELECT strftime('%H', tpep_pickup_datetime) AS hour_of_day, COUNT(*) AS ride_count
FROM taxi_trips
GROUP BY hour_of_day
ORDER BY ride_count DESC
