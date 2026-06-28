SELECT order_date, CONCAT (name, ' (age:', age::TEXT, ')') AS personal_information FROM public.person_order
JOIN public.person ON person_order.person_id = person.id
ORDER BY order_date ASC, personal_information ASC 