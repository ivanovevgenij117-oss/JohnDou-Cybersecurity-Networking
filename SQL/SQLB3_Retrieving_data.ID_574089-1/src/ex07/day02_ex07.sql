SELECT 
	pizzeria.name 
	FROM 
		public.person_visits

JOIN person ON person_visits.person_id = person.id
JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id

WHERE person.name = 'Dmitriy' AND visit_date = '2022-01-08'
AND EXISTS(
	SELECT 1
	FROM menu
	WHERE menu.pizzeria_id = pizzeria.id
	AND menu.price < 800
)

--ORDER BY id ASC 