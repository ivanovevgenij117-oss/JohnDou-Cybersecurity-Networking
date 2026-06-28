SELECT
	name,
	SUM(count) AS total_count
FROM
	((SELECT 
		name,
		COUNT(*) AS count,
		'visit' AS action_type
	 FROM public.person_visits
	JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
	GROUP BY name
	)
	
	UNION ALL
	
	(SELECT
		name,
		COUNT (*) AS count,
		'order' AS action_type
	FROM person_order
	JOIN menu ON menu_id = menu.id
	JOIN pizzeria ON pizzeria_id = pizzeria.id
	GROUP BY name
	)) AS t100
GROUP BY name
 
ORDER BY total_count DESC, name DESC