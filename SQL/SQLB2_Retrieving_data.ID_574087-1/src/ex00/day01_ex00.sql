SELECT id AS object_id, pizza_name AS object_name
FROM public.menu

UNION ALL

SELECT id AS object_id, name  AS object_name
FROM public.person
ORDER by object_id ASC, object_name ASC