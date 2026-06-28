SELECT name 
	FROM public.pizzeria
WHERE NOT EXISTS (
	SELECT 1 
	FROM public.person_visits
	WHERE public.person_visits.pizzeria_id = public.pizzeria.id)
--ORDER BY id ASC 