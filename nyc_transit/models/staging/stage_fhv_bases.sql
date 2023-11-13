-- Author: Mia Luo
-- andrewId: manluo
-- This script is designed to clean up the `fhv_bases` table and store as temparory view at staging model

with source as (
    select * from {{ source('main', 'fhv_bases') }}
),
--- dba has too many missing values
stage_fhv_bases as (
    select 
        trim(upper(base_number)) as base_number,
        trim(base_name) as base_name,
        dba,
        trim(dba_category) as dba_category,
        filename
    from source 
    where trim(upper(base_number)) is not null
)

select * from stage_fhv_bases
where base_number is not null