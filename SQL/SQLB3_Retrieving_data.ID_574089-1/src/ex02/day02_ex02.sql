SELECT 
	COALESCE(person.name, '-') AS person_name,
	person_visits.visit_date,
	COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM 
	person
FULL OUTER JOIN 
	person_visits ON person.id = person_visits.person_id
	AND person_visits.visit_date BETWEEN '2022-01-01' AND '2022-01-03'
FULL OUTER JOIN 
	pizzeria ON person_visits.pizzeria_id = pizzeria.id
	AND person_visits.visit_date BETWEEN '2022-01-01' AND '2022-01-03'

WHERE 
 	person_visits.visit_date BETWEEN '2022-01-01' AND '2022-01-03' 
	OR 
	person_visits.visit_date IS NULL

ORDER BY 
    person_name ASC, visit_date ASC, pizzeria_name ASC