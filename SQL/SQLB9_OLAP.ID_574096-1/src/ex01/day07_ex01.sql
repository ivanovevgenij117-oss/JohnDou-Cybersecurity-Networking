SELECT 
	person.name,
	COUNT (*) AS count_of_visits --можно и так: COUNT (visit_date)
FROM public.person_visits
JOIN  person ON person_visits.person_id = person.id
GROUP BY person_id, person.name	--группировка по ид введена на случай, вдруг есть люди с одинаковым именем
ORDER BY count_of_visits DESC, person.name ASC 
LIMIT 4;