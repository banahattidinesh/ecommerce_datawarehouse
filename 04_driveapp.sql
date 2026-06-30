-- Step 1: Create the clean reference Dimension tables
CREATE TABLE dim_driver (
    driver_key SERIAL PRIMARY KEY,
    driver_name VARCHAR(100),
    driver_rating DECIMAL(3,2)
);

CREATE TABLE dim_rider (
    rider_key SERIAL PRIMARY KEY,
    rider_name VARCHAR(100),
    rider_phone VARCHAR(20)
);

CREATE TABLE dim_location (
    location_key SERIAL PRIMARY KEY,
    city_name VARCHAR(50)
);

-- Step 2: Create the central numerical Fact table
CREATE TABLE fact_rides (
    ride_id INT PRIMARY KEY,
    driver_key INT,
    rider_key INT,
    pickup_location_key INT,
    dropoff_location_key INT,
    miles_driven DECIMAL(10,2),
    total_fare DECIMAL(10,2)
);

-- Step 3: Insert sample clean warehouse records
INSERT INTO dim_driver (driver_name, driver_rating) VALUES ('Amit Kumar', 4.8), ('Sara Khan', 4.9);
INSERT INTO dim_rider (rider_name, rider_phone) VALUES ('Dinesh B', '9876543210'), ('Neha Sharma', '9123456789');
INSERT INTO dim_location (city_name) VALUES ('Pune'), ('Solapur'), ('Mumbai');

-- Insert a ride from Pune to Solapur driven by Amit for rider Dinesh
INSERT INTO fact_rides (ride_id, driver_key, rider_key, pickup_location_key, dropoff_location_key, miles_driven, total_fare)
VALUES (1001, 1, 1, 1, 2, 250.00, 3500.00);




select a.rider_name, b.driver_name, c.miles_driven, c.total_fare
from dim_rider a
join fact_rides c on a.rider_key = c.rider_key
join dim_driver b on c.driver_key = b.driver_key;


CREATE TABLE dim_date (
    full_date DATE PRIMARY KEY,
    day_of_week VARCHAR(10),
    is_weekend BOOLEAN,
    quarter INT
);


-- We use Postgres's built-in generate_series function to automatically create 365 rows
INSERT INTO dim_date (full_date, day_of_week, is_weekend, quarter)
SELECT 
    datum AS full_date,
    TRIM(TO_CHAR(datum, 'Day')) AS day_of_week,
    EXTRACT(ISODOW FROM datum) IN (6, 7) AS is_weekend,
    EXTRACT(QUARTER FROM datum) AS quarter
FROM generate_series('2023-01-01'::date, '2023-12-31'::date, '1 day') AS datum;

-- Check your work
SELECT * FROM dim_date WHERE full_date BETWEEN '2023-10-01' AND '2023-10-05';