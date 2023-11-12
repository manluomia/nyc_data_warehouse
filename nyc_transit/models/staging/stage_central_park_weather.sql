-- Author: Mia Luo
-- andrewId: manluo
-- This script is to clean up central_park_weather table

with source as (
    select * from {{ source('main', 'central_park_weather') }}
),

stage_central_park_weather as (
    select 
        trim(STATION) as station_code,
        trim(NAME) as station_name,
        DATE::DATE as date,
        AWND::float as average_wind_speed,
        PRCP::float as precipation,
        SNOW::float as snowfall,
        SNWD::float as snow_depth,
        TMAX::float as max_temp,
        TMIN::float as min_temp,
        filename
    from source 
    where date is not null
)

select * from stage_central_park_weather