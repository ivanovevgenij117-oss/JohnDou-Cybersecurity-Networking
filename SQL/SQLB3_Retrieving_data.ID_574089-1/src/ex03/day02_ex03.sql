WITH dates AS(
	SELECT generate_series(
		'2022-01-01'::date,
		'2022-01-10'::date,
		'1 day'::interval
	)::date AS dt
)
SELECT dates.dt AS missing_date FROM dates

LEFT JOIN person_visits pv1 ON dates.dt = pv1.visit_date AND pv1.person_id = 1
LEFT JOIN person_visits pv2 ON dates.dt = pv2.visit_date AND pv2.person_id = 2
WHERE pv1.visit_date IS NULL AND pv2.visit_date IS NULL

ORDER BY missing_date ASC