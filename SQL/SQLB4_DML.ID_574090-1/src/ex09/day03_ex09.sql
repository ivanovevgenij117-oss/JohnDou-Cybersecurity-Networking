WITH last_id AS (
    SELECT MAX(id) AS max_id FROM person_visits
) --узнаем максимальный ИД один раз в виде временной таблиц

INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
	VALUES ((SELECT max_id + 1 FROM last_id), -- и используем его дважды. ПЕРВЫЙ РАЗ
	(SELECT id FROM person WHERE name = 'Denis'),
	(SELECT id FROM pizzeria WHERE name = 'Dominos'),
	'2022-02-24'),
		((SELECT max_id + 2 FROM last_id), -- ВТОРОЙ РАЗ
		(SELECT id FROM person WHERE name = 'Irina'),
		(SELECT id FROM pizzeria WHERE name = 'Dominos'),
		'2022-02-24')