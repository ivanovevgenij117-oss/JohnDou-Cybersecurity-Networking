SELECT DISTINCT name FROM public.person_order
JOIN person ON person_id = person.id
ORDER BY name ASC