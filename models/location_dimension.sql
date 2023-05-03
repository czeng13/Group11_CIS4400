{{ config(materialized='table') }}

with location_dimension AS

(

SELECT

row_number() OVER () AS location_dim_id, *

FROM (

SELECT DISTINCT incident_zip AS zipcode, incident_address,
                                city, 
                                community_board AS community_district,
                                bbl,
                                borough,
                                location_type


FROM {{ ref('src_311_complaints') }}

ORDER BY 1, 2

)

)

SELECT * FROM location_dimension