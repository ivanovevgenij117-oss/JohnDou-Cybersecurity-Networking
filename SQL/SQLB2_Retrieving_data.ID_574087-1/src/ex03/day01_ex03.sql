SELECT order_date AS action_data, person_id FROM public.person_order
INTERSECT
SELECT visit_date AS action_data, person_id FROM public.person_visits

ORDER by action_data ASC, person_id DESC 