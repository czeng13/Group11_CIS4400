SELECT * 
FROM {{ ref('location_dimension') }} AS l1
INNER JOIN {{ ref('arrests_location_dimension') }} AS l2
ON l1.location_dim_id = l2.arrests_location_dim_id