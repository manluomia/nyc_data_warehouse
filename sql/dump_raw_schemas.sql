-- Author: Mia Luo
-- andrewId: manluo
-- This script will printout table details in the duckdb 
-- duckdb command line: duckdb main.db -s ".read sql/dump_raw_schemas.sql" > answers/raw_schemas.txt

.echo on

-- Displaying and Describing Bike Data
-- Show contents of the bike_data table
SHOW bike_data;

-- Describe the structure and columns of the bike_data table
DESCRIBE bike_data;

-- Displaying and Describing Central Park Weather Data
-- Show contents of the central_park_weather table
SHOW central_park_weather;

-- Describe the structure and columns of the central_park_weather table
DESCRIBE central_park_weather;

-- Displaying and Describing FHV Bases Data
-- Show contents of the fhv_bases table
SHOW fhv_bases;

-- Describe the structure and columns of the fhv_bases table
DESCRIBE fhv_bases;

-- Displaying and Describing FHV Trip Data
-- Show contents of the fhv_tripdata table
SHOW fhv_tripdata;

-- Describe the structure and columns of the fhv_tripdata table
DESCRIBE fhv_tripdata;

-- Displaying and Describing FHVHV Trip Data
-- Show contents of the fhvhv_tripdata table
SHOW fhvhv_tripdata;

-- Describe the structure and columns of the fhvhv_tripdata table
DESCRIBE fhvhv_tripdata;

-- Displaying and Describing Green Trip Data
-- Show contents of the green_tripdata table
SHOW green_tripdata;

-- Describe the structure and columns of the green_tripdata table
DESCRIBE green_tripdata;

-- Displaying and Describing Yellow Trip Data
-- Show contents of the yellow_tripdata table
SHOW yellow_tripdata;

-- Describe the structure and columns of the yellow_tripdata table
DESCRIBE yellow_tripdata;