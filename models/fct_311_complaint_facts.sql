{{
config(
    materialized='table'
)
}}

WITH agency_dimension AS
(
    SELECT * FROM {{ ref('agency_dimension') }}
),

complaint_type_dimension AS
(
    SELECT * FROM {{ ref('complaint_type_dimension')}}
),

location_dimension AS
(
    SELECT * FROM {{ ref('location_dimension') }}
),

date_dimension AS
(
    SELECT * FROM {{ ref('date_dimension') }}
),

all_complaints AS
(
    SELECT * FROM {{ ref('src_311_complaints') }}
)

SELECT ad.agency_dim_id, 
        ctd.complaint_type_dim_id, 
        ld.location_dim_id,
        dd.date_dim_id, 
        1 AS complaint_count

FROM all_complaints ac

INNER JOIN agency_dimension ad
USING (agency, agency_name)

INNER JOIN complaint_type_dimension ctd
USING (complaint_type, descriptor)

INNER JOIN location_dimension ld
USING (incident_zip, incident_address,
                                city, 
                                community_board,
                                bbl,
                                borough,
                                location_type)

INNER JOIN date_dimension dd ON EXTRACT(DATE FROM ac.created_date) = dd.full_date