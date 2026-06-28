
SELECT(
	SELECT name 
	FROM public.person
	WHERE id = public.person_order.person_id
	) AS person_name,
	
	CASE
		WHEN (
			SELECT name
			FROM public.person
			WHERE id = public.person_order.person_id
 		) = 'Denis' THEN true ELSE false
	END AS check_name
	
	FROM public.person_order
	WHERE (person_order.menu_id = 13 OR person_order.menu_id = 14 OR person_order.menu_id = 18) 
		AND person_order.order_date = '2022-01-07'