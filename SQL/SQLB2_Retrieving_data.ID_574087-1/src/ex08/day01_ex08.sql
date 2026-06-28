SELECT 
	order_date, 
	CONCAT (name, ' (age:', age::TEXT, ')') AS personal_information 
FROM 
	(SELECT person_id AS id, order_date FROM public.person_order) AS po --сначала переименовываем столбец
	NATURAL JOIN public.person --затем склеиваем. И только потом выполняется внешний SELECT

ORDER BY order_date ASC,
personal_information ASC 