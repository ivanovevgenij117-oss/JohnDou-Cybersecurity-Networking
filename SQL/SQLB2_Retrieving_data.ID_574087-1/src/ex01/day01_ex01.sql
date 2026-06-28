SELECT object_name FROM(
	SELECT pizza_name AS object_name, 2 AS sort_key
	FROM public.menu

	UNION ALL

	SELECT name  AS object_name, 1 AS sort_key
	FROM public.person) AS combined_data

ORDER by sort_key ASC, object_name ASC 