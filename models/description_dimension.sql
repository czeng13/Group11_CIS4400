{{ config(materialized='table') }}

with description_dimension AS

(

SELECT

row_number() OVER () AS description_dim_id, *

FROM (

SELECT DISTINCT age_group, perp_sex

FROM {{ ref('src_arrests') }}

ORDER BY 1, 2

)

)

SELECT * FROM description_dimension