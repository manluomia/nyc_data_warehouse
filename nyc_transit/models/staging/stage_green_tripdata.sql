-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up green_tripdata table

with source as (
    select * from {{ source('main', 'green_tripdata') }}
),
--- ehail  has too many missing values
stage_green_tripdata as (
    select 
        VendorID,
        lpep_pickup_datetime as pickup_datetime,
        lpep_dropoff_datetime as dropoff_datetime,
        {{flag_to_bool("store_and_fwd_flag")}} as store_and_fwd_flag, 
        RatecodeID as find_rate_code,
        PULocationID as begin_taxi_zone,
        DOLocationID as end_taxi_zone,
        passenger_count,
        trip_distance,
        fare_amount,
        extra as extra_surcharge,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename
    from source 
    where pickup_datetime <= '2022-12-31' and dropoff_datetime <= '2022-12-31' and passenger_count > 0
    and trip_distance>=0 and fare_amount>0 and total_amount>0 
)

select * from stage_green_tripdata
where trip_distance between 0 and 10000