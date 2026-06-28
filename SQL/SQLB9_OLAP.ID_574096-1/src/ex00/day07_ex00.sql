SELECT 
	person_id,
	COUNT (*) AS count_of_visits --можно и так: COUNT (visit_date)
FROM public.person_visits
GROUP BY person_id
ORDER BY count_of_visits DESC, person_id ASC 