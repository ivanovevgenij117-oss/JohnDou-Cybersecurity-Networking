WITH visits_by_gender AS(
	SELECT
		pizzeria.name AS pizzeria_name,
		gender , 
		COUNT (*) AS visit_count
	FROM public.person_visits pv

	JOIN person p ON pv.person_id = p.id 
	JOIN pizzeria ON pizzeria_id = pizzeria.id
	GROUP BY pizzeria_name, gender)
	
SELECT
	pizzeria_name --,
--    MAX(CASE WHEN gender = 'male' THEN visit_count ELSE 0 END) AS male_visits,
--    MAX(CASE WHEN gender = 'female' THEN visit_count ELSE 0 END) AS female_visits
FROM
	visits_by_gender
GROUP BY pizzeria_name

HAVING ABS(MAX(CASE WHEN gender = 'male' THEN visit_count ELSE 0 END) - MAX(CASE WHEN gender = 'female' THEN visit_count ELSE 0 END)) > 0

ORDER BY pizzeria_name ASC