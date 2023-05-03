{{ config(materialized='table') }}

with crime_type_dimension AS

(

SELECT

row_number() OVER () AS crime_type_dim_id, *

FROM (

SELECT DISTINCT pd_cd, pd_desc

FROM {{ ref('src_arrests') }}

ORDER BY 1, 2

)

)

SELECT * FROM crime_type_dimension