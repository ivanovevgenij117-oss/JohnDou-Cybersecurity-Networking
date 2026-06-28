SELECT pizzeria.name AS pizzeria_name
FROM person_visits
JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
WHERE person_id = (SELECT id FROM person WHERE name = 'Andrey') 

except

SELECT pizzeria.name AS pizzeria_name
FROM person_order
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
WHERE person_id = (SELECT id FROM person WHERE name = 'Andrey')

ORDER BY pizzeria_name ASC