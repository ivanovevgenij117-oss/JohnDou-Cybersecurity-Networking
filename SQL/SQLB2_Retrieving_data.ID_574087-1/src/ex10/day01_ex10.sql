SELECT 
	person.name AS person_name, 
	menu.pizza_name,
	pizzeria.name AS pizzeria_name
FROM 
	public.person_order
JOIN 
	public.person ON public.person_order.person_id = public.person.id
JOIN 
	public.menu ON public.person_order.menu_id = public.menu.id
JOIN
	public.pizzeria ON public.menu.pizzeria_id = public.pizzeria.id

ORDER BY person_name ASC, pizza_name ASC, pizzeria_name ASC