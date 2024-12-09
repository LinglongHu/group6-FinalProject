
CREATE TABLE IF NOT EXISTS hourly_weather (
    timestamp DATETIME PRIMARY KEY,
    temperature FLOAT,
    precipitation FLOAT,
    wind_speed FLOAT,
    humidity FLOAT
);

CREATE TABLE IF NOT EXISTS daily_weather (
    date DATE PRIMARY KEY,
    max_temperature FLOAT,
    precipitation FLOAT,
    snowfall FLOAT,
    humidity FLOAT
);

CREATE TABLE IF NOT EXISTS taxi_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tpep_pickup_datetime DATETIME,
    tpep_dropoff_datetime DATETIME,
    trip_distance FLOAT,
    fare_amount FLOAT,
    tip_amount FLOAT,
    latitude_pickup1 FLOAT,
    latitude_dropoff1 FLOAT,
    longitude_pickup1 FLOAT,
    longitude_dropoff1 FLOAT,
    fare_amount FLOAT,
    trip_distance FLOAT,
    total_amount FLOAT,
    tip_amount FLOAT
);

CREATE TABLE IF NOT EXISTS uber_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pickup_datetime DATETIME,
    dropoff_datetime DATETIME,
    trip_miles FLOAT,
    base_passenger_fare FLOAT,
    latitude_pickup2 FLOAT,
    longitude_pickup2 FLOAT,
    latitude_dropoff2 FLOAT,
    longitude_dropoff2 FLOAT,
    tolls FLOAT,
    tips FLOAT
);
