
SELECT
	pizza_name,
	price,
	name AS pizzeria_name
FROM public.menu

LEFT JOIN person_order ON person_order.menu_id = menu.id 
JOIN pizzeria ON menu.pizzeria_id =  pizzeria.id

WHERE person_order.menu_id IS NULL

ORDER BY pizza_name ASC, price ASC