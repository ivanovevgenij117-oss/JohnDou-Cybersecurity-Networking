--почемуто в задании в примере вывода нет вывода двух знаков после запятой
SELECT 
	name,
	count(*) AS count_of_orders,
	(round(AVG(price)::numeric, 2))::float AS average_price, --float убирает незначащие нули
	MAX(price) AS max_price,
	MIN(price) AS min_price
 FROM public.person_order
JOIN menu ON menu_id = menu.id
join pizzeria on pizzeria_id = pizzeria.id
group by name
ORDER BY name ASC