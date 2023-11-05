-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up yellow_tripdata table

with source as (
    select * from {{ source('main', 'yellow_tripdata') }}
),
--- ehail has too many missing values
stage_yellow_tripdata as (
    select 
        VendorID,
        tpep_pickup_datetime as pickup_datetime,
        tpep_dropoff_datetime as dropoff_datetime,
        passenger_count,
        trip_distance,
        RatecodeID as find_rate_code,
        CASE
            WHEN upper(store_and_fwd_flag) = 'Y' THEN TRUE
            WHEN upper(store_and_fwd_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS store_and_fwd_flag,
        PULocationID as begin_taxi_zone,
        DOLocationID as end_taxi_zone,
        payment_type,
        fare_amount,
        extra as extra_surcharge,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        filename,
    from source 
    where pickup_datetime <= '2022-12-31' and dropoff_datetime <= '2022-12-31' and passenger_count > 0
    and trip_distance>0 and fare_amount>0 and total_amount>0
)

select * from stage_yellow_tripdata