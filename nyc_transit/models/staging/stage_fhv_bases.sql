-- Author: Mia Luo
-- andrewId: manluo
-- This script is designed to clean up the `fhv_bases` table and store as temparory view at staging model

with source as (
    select * from {{ source('main', 'fhv_bases') }}
),
--- dba has too many missing values
stage_fhv_bases as (
    select 
        trim(base_number) as base_number,
        trim(base_name) as base_name,
        trim(dba_category) as dba_category,
        filename
    from source 
)

select * from stage_fhv_bases