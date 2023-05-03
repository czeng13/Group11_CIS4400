{{ config(materialized='table') }}

with complaint_type_dimension AS

(

SELECT

row_number() OVER () AS complaint_type_dim_id, *

FROM (

SELECT DISTINCT complaint_type, descriptor

FROM {{ ref('src_311_complaints') }}

ORDER BY 1, 2

)

)

SELECT * FROM complaint_type_dimension