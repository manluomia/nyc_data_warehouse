# NYC Transportation Data Warehouse Project
## Objective: 
Combine taxi, rideshare, and bikeshare data with weather data to answer questions about transit preferences. 

## Data Sources
[NYC Citi Bikes](https://citibikenyc.com/system-data)  
[Yellow and green taxi trip records](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page)  
[FHV Base Aggregate Report](https://data.cityofnewyork.us/Transportation/FHV-Base-Aggregate-Report/2v9c-2k7f)  
[NYC Weather Report](https://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/stations/GHCND:USW00094728/detail)

## Tech Stack
- DBT
- DuckDB
- AWS
- DBeaver

## Project Overview
### Stage 1
Ingest data from AWS S3 bucket using awscli 
Store data in duckdb by drafting ingest and schema sql

### Stage 2
Automate data transformation using DBT tool by defining model transformation and testing in dbt models 
