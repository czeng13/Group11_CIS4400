{{

config(

materialized='table'

)

}}

WITH arrest_date_dimension AS

(

SELECT * FROM {{ ref('arrest_date_dimension') }}

),

crime_type_dimension AS

(

SELECT * FROM {{ ref('crime_type_dimension') }}

),

arrests_location_dimension AS

(

SELECT * FROM {{ ref('arrests_location_dimension') }}

),

description_dimension AS

(

SELECT * FROM {{ ref('description_dimension') }}

),

all_arrests AS

(

SELECT * FROM {{ ref('src_arrests') }}

)

SELECT aadd.arrest_date_dim_id, ald.arrests_location_dim_id, ctd.crime_type_dim_id,

dd.description_dim_id, 1 AS complaint_count

FROM all_arrests aa

INNER JOIN arrests_location_dimension ald

USING (arrest_boro, arrest_precinct)

INNER JOIN crime_type_dimension ctd

USING (pd_cd, pd_desc)

INNER JOIN description_dimension dd

USING (age_group, perp_sex)

INNER JOIN arrest_date_dimension aadd ON EXTRACT(DATE FROM aa.arrest_date) = aadd.full_date