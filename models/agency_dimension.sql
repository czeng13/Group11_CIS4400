{{ config(materialized='table') }}

with agency_dimension AS

(

SELECT

row_number() OVER () AS agency_dim_id, *

FROM (

SELECT DISTINCT agency, agency_name

FROM {{ ref('src_311_complaints') }}

ORDER BY 1, 2

)

)

SELECT * FROM agency_dimension