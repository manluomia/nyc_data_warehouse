-- Author: Mia Luo
-- andrewId: manluo
-- This script will printout table details in the duckdb 
-- duckdb command line: duckdb main.db -s ".read sql/stage_schema.sql" > answers/stage_schemas.txt

.echo on

SHOW staging.stage_bike_data;

DESCRIBE staging.stage_bike_data;


SHOW staging.stage_central_park_weather;

DESCRIBE staging.stage_central_park_weather;

SHOW staging.stage_fhv_bases;

DESCRIBE staging.stage_fhv_bases;

SHOW staging.stage_fhv_tripdata;


DESCRIBE staging.stage_fhv_tripdata;


SHOW staging.stage_fhvhv_tripdata;


DESCRIBE staging.stage_fhvhv_tripdata;

SHOW staging.stage_green_tripdata;

DESCRIBE staging.stage_green_tripdata;

SHOW staging.stage_yellow_tripdata;

DESCRIBE staging.stage_yellow_tripdata;