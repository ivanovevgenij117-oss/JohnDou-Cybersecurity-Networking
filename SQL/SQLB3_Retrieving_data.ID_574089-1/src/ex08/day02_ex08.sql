SELECT name FROM public.person_order

JOIN person ON person_order.person_id = person.id
JOIN menu ON person_order.menu_id = menu.id
WHERE gender = 'male' 
	AND (address = 'Samara' OR address = 'Moscow')
	AND (pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza')

ORDER BY name DESC 