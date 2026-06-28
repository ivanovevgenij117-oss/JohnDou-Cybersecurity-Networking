SELECT 
	pizza_name,
	name AS pizzeria_name,
	price
	FROM 
		public.menu
		
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
WHERE pizza_name = 'pepperoni pizza' OR pizza_name = 'mushroom pizza'

ORDER BY pizza_name ASC, pizzeria_name ASC 