SELECT 
	person.id AS person_id,
	person.name,
	person.age,
	person.gender,
	person.address,
	pizzeria.id,
	pizzeria.name,
	pizzeria.rating
FROM person

CROSS JOIN 
pizzeria
ORDER BY person_id