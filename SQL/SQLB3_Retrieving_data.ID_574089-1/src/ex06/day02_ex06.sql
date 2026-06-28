SELECT 
	pizza_name,
	pizzeria.name AS pizzeria_name
		FROM 
			public.person_order
			
JOIN person ON person.id = person_order.person_id
JOIN menu ON person_order.menu_id = menu.id
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id

WHERE person.name = 'Anna' OR person.name ='Denis'

ORDER BY pizza_name ASC, pizzeria_name ASC 