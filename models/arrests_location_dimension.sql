{{ config(materialized='table') }}

with arrests_location_dimension AS

(

SELECT

row_number() OVER () AS arrests_location_dim_id, *

FROM (

SELECT DISTINCT  arrest_boro, arrest_precinct

FROM {{ ref('src_arrests') }}

ORDER BY 1, 2

)

)

SELECT * FROM arrests_location_dimension