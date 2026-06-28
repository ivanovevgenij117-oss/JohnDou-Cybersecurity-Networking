SELECT 
	name,
	COUNT(*) AS count_of_visits
 FROM public.person_visits
JOIN person ON person_id = person.id
GROUP BY name
HAVING COUNT(*) > 3 