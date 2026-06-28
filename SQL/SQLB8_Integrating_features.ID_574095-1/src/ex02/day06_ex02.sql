SELECT 
	person.name AS name,
	pizza_name,
	price,
	(price - price*discount/100)::float AS discount_price,
	pizzeria.name AS pizzeria_name
FROM public.person_order
JOIN menu ON person_order.menu_id = menu.id
JOIN person ON person_order.person_id = person.id
JOIN pizzeria ON pizzeria_id = pizzeria.id
JOIN person_discounts ON (person_order.person_id = person_discounts.person_id
AND menu.pizzeria_id = person_discounts.pizzeria_id)
ORDER BY name ASC, pizza_name ASC