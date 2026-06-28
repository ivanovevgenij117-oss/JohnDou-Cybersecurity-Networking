SELECT person_id FROM public.person_order WHERE order_date = '2022-01-07'
EXCEPT ALL --в pgAdmin4 нет операции MINUS
SELECT person_id FROM public.person_visits WHERE visit_date = '2022-01-07'

ORDER BY person_id ASC 