SELECT order_date AS action_data, name AS person_name FROM public.person_order
JOIN public.person ON person_order.person_id = person.id

INTERSECT

SELECT visit_date AS action_data, name AS person_name FROM public.person_visits
JOIN public.person ON person_visits.person_id = person.id

ORDER by action_data ASC, person_name DESC 
