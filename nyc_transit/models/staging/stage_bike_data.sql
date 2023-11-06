-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up bike_data table in the staging model.

-- The raw data was partition into two format with all string types. This code is to unifiy the format
-- cast to correct data type and make it easy to read and understand.

-- Need to download dbt and configure connection to duckdb main schema
-- import this into staging model directory
-- use dbt run command to execute the model
-- check if the view exists by using duckdb ../main.db


with source as (
    select * from {{ source('main', 'bike_data') }}
),

first_part_raw as (
    select 
        tripduration :: float as tripduration,
        "starttime"::timestamp as start_time,
        "stoptime"::timestamp as stop_time,
        "start station id"::varchar as start_station_id,
        "start station name"::varchar as start_station_name,
        "start station latitude"::float as start_station_lat,
        "start station longitude"::float as start_station_lng,
        "end station id"::varchar as end_station_id,
        "end station name"::varchar as end_station_name,
        "end station latitude"::float as end_station_lat,
        "end station longitude"::float as end_station_lng,
        case when "gender" = '1' then 'male'
            when "gender" = '2' then 'female'
            else null
        end as gender,
        "birth year":: INTEGER as birth_year,
        bikeid::INTEGER as bikeid,
        usertype,
        filename
    from source
    where tripduration is not null
),
first_part as (
    select 
        tripduration,
        start_time,
        stop_time,
        trim(start_station_id) as start_station_id,
        trim(start_station_name) as start_station_name,
        start_station_lat,
        start_station_lng,
        trim(end_station_id) as end_station_id,
        trim(end_station_name) as end_station_name,
        end_station_lat,
        end_station_lng,
        gender,
        birth_year,
        bikeid,
        trim(usertype) as usertype,
        filename
    from first_part_raw
    where tripduration > 0 and start_time > '2000-01-01' and stop_time <= '2022-12-31'

),
--- Some of the end_station_id is string type so all the ids are casted to string
second_part_raw as (
    select
        started_at::timestamp as start_time,
        ended_at::timestamp as stop_time,
        start_station_id::varchar as start_station_id,
        start_station_name::varchar as start_station_name,
        start_lat::float as start_station_lat,
        start_lng::float as start_station_lng,   
        end_station_id::varchar as end_station_id,
        end_station_name::varchar as end_station_name,
        end_lat::float as end_station_lat,
        end_lng::float as end_station_lng,
        NULL as gender,
        NULL as birth_year,
        NULL as bikeid,
        NULL as usertype,
        filename::varchar as filename
    from source
    where tripduration is null
),
second_part as (
    select
        (stop_time - start_time) :: float as tripduration,
        start_time,
        stop_time,
        trim(start_station_id) as start_station_id,
        trim(start_station_name) as start_station_name,
        start_station_lat,
        start_station_lng,
        trim(end_station_id) as end_station_id,
        trim(end_station_name) as end_station_name,
        end_station_lat,
        end_station_lng,
        gender,
        birth_year,
        bikeid,
        usertype,
        filename
    from second_part_raw
    where (stop_time - start_time) > 0 and start_time > '2000-01-01' and stop_time <= '2022-12-31'
),

stage_bike_data as (
    select * from first_part
    union all 
    select * from second_part
)

select * from stage_bike_data