
SELECT trip_distance
FROM taxi_trips
UNION ALL
SELECT trip_miles AS trip_distance
FROM uber_trips
