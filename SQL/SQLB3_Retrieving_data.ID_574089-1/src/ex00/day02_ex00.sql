SELECT 
	name,
	rating
	FROM 
		public.person_visits
		
RIGHT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
WHERE visit_date IS NULL

--ORDER BY id ASC 