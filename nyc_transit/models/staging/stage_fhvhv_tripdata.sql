-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up fhvhv_tripdata table

with source as (
    select * from {{ source('main', 'fhvhv_tripdata') }}
), -- SR_Flag has too many missing values

stage_fhvhv_tripdata as (
    select 
        trim(hvfhs_license_num) as hvfhs_license_num,
        trim(dispatching_base_num) as dispatching_base_num,
        trim(originating_base_num) as originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        PULocationID as begin_taxi_zone,
        DOlocationID as end_taxi_zone,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf as black_car_fund_amount,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        CASE
            WHEN upper(shared_request_flag) = 'Y' THEN TRUE
            WHEN upper(shared_request_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS aggred_to_share,
        CASE
            WHEN upper(shared_match_flag) = 'Y' THEN TRUE
            WHEN upper(shared_match_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS shared_ride,
        CASE
            WHEN upper(access_a_ride_flag) = 'Y' THEN TRUE
            WHEN upper(access_a_ride_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS trip_by_MTA,
        CASE
            WHEN upper(wav_request_flag) = 'Y' THEN TRUE
            WHEN upper(wav_request_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS wheelchair_request,
        CASE
            WHEN upper(wav_match_flag) = 'Y' THEN TRUE
            WHEN upper(wav_match_flag) = 'N' THEN FALSE
            ELSE NULL 
        END AS wheelchair_trip,
        filename
    from source 
    where request_datetime < '2022-12-31'
      and on_scene_datetime < '2022-12-31'
      and pickup_datetime < '2022-12-31'
      and dropoff_datetime < '2022-12-31'
      and trip_miles >= 0
      and trip_time >= 0
      and base_passenger_fare >= 0
)

select * from stage_fhvhv_tripdata
