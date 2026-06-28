SELECT 
	(SELECT name FROM public.person WHERE id=pv.person_id) AS person_name,
	(SELECT name FROM public.pizzeria WHERE id=pv.pizzeria_id) AS pizzeria_name
FROM (
	SELECT person_id, pizzeria_id FROM public.person_visits
		WHERE (public.person_visits.visit_date BETWEEN '2022-01-07' AND '2022-01-09')
	) AS pv
ORDER BY person_name ASC, pizzeria_name DESC