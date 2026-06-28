SELECT name FROM public.pizzeria
WHERE id NOT IN (SELECT pizzeria_id FROM public.person_visits)
--ORDER BY id ASC 