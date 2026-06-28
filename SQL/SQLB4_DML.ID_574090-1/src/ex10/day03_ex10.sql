WITH last_id AS (
    SELECT MAX(id) AS max_id FROM person_order
) --узнаем максимальный ИД один раз в виде временной таблиц

INSERT INTO person_order(id, person_id, menu_id, order_date)
	VALUES ((SELECT max_id+1 FROM last_id),
		(SELECT id FROM person WHERE name = 'Denis'),
		(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
		'2022-02-24'),
	((SELECT max_id + 2 FROM last_id), -- ВТОРОЙ РАЗ
	(SELECT id FROM person WHERE name = 'Irina'),
	(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
	'2022-02-24')