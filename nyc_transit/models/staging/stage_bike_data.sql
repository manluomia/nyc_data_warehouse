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

renamed as (

    select
        tripduration,
        starttime,
        stoptime,
        "start station id",
        "start station name",
        "start station latitude",
        "start station longitude",
        "end station id",
        "end station name",
        "end station latitude",
        "end station longitude",
        bikeid,
        usertype,
        "birth year",
        gender,
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        member_casual,
        filename

    from source

), 

temp as (

select
	coalesce(starttime, started_at)::timestamp as started_at_ts,
	coalesce(stoptime, ended_at)::timestamp as ended_at_ts,
    case 
        when tripduration is not null and tripduration ~ '^[0-9]+$' then
            cast(tripduration as int)
        when tripduration is not null and not tripduration ~ '^[0-9]+$' then
            0
        else
            greatest(datediff('second', started_at_ts, ended_at_ts), 0)
    end as tripduration,
	coalesce("start station id", start_station_id) as start_station_id,  
	coalesce("start station name", start_station_name) as start_station_name,
	coalesce("start station latitude", start_lat)::double as start_lat,
	coalesce("start station longitude", start_lng)::double as start_lng, 
	coalesce("end station id", end_station_id) as end_station_id,  
	coalesce("end station name", end_station_name) as end_station_name,
	coalesce("end station latitude", end_lat)::double as end_lat,
	coalesce("end station longitude", end_lng)::double as end_lng,
	filename
from renamed
)

select *
from temp
where tripduration between 0 and 10000