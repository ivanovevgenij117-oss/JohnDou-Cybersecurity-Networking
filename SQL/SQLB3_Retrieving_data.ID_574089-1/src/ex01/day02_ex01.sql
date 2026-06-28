SELECT dates.dt::date 
	FROM generate_series(
		'2022-01-01'::date,
		'2022-01-10'::date,
		'1 DAY'::interval
		) AS dates(dt)
	
LEFT JOIN person_visits pv1 ON dates.dt = pv1.visit_date AND pv1.person_id = 1
LEFT JOIN person_visits pv2 ON dates.dt = pv2.visit_date AND pv2.person_id = 2
WHERE pv1.visit_date IS NULL AND pv2.visit_date IS NULL

