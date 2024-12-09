
SELECT strftime('%w', pickup_datetime) AS day_of_week, COUNT(*) AS ride_count
FROM uber_trips
GROUP BY day_of_week
ORDER BY ride_count DESC
