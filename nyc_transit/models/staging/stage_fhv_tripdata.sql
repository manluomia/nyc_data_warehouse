-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up fhv_bases table

with source as (
    select * from {{ source('main', 'fhv_tripdata') }}
),
--- SR_Flag  has too many missing values
stage_fhv_tripdata as (
    select 
        trim(upper(dispatching_base_num)) as base_license_number,
        pickup_datetime as pickup_time,
        dropOff_datetime as dropff_time,
        PUlocationID as begin_taxi_zone,
        DOlocationID as end_taxi_zone,
        trim(upper(affiliated_base_number)) as affiliated_base_number,
        filename
    from source 
)

select * from stage_fhv_tripdata