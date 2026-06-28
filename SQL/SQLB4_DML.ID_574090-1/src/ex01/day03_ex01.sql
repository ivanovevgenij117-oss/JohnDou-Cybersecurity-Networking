SELECT
	menu.id AS menu_id
FROM public.menu

LEFT JOIN person_order ON person_order.menu_id = menu.id 

WHERE person_order.menu_id IS NULL

ORDER BY menu_id ASC