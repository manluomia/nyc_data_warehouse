-- Author: Mia Luo
-- andrewId: manluo
-- This script import local data to duckdb
-- duckdb command line: duckdb main.db -s ".read sql/ingest.sql"

.echo on

-- Ingesting Bike Data
-- If table bike_data exists, drop it to ensure a fresh start
DROP TABLE IF EXISTS bike_data;

-- Create the bike_data table and ingest data from citibike-tripdata.csv.gz
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('data/citibike-tripdata.csv.gz', filename = True);

-- Ingesting Central Park Weather Data
-- If table central_park_weather exists, drop it
DROP TABLE IF EXISTS central_park_weather;

-- Create the central_park_weather table and ingest data from central_park_weather.csv
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('data/central_park_weather.csv', filename = True);

-- Ingesting FHV Bases Data
-- If table fhv_bases exists, drop it
DROP TABLE IF EXISTS fhv_bases;

-- Create the fhv_bases table and ingest data from fhv_bases.csv
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('data/fhv_bases.csv', filename = True, header = True);

-- Ingesting FHV Trip Data
-- If table fhv_tripdata exists, drop it
DROP TABLE IF EXISTS fhv_tripdata;

-- Create the fhv_tripdata table and ingest data from fhv_tripdata.parquet
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('data/taxi/fhv_tripdata.parquet',filename = True);

-- Ingesting FHVHV Trip Data
-- If table fhvhv_tripdata exists, drop it
DROP TABLE IF EXISTS fhvhv_tripdata;

-- Create the fhvhv_tripdata table and ingest data from fhvhv_tripdata.parquet
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('data/taxi/fhvhv_tripdata.parquet', filename = True);

-- Ingesting Green Trip Data
-- If table green_tripdata exists, drop it
DROP TABLE IF EXISTS green_tripdata;

-- Create the green_tripdata table and ingest data from green_tripdata.parquet
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('data/taxi/green_tripdata.parquet', filename = True);

-- Ingesting Yellow Trip Data
-- If table yellow_tripdata exists, drop it
DROP TABLE IF EXISTS yellow_tripdata;

-- Create the yellow_tripdata table and ingest data from yellow_tripdata.parquet
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('data/taxi/yellow_tripdata.parquet', filename = True);