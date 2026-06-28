(SELECT p2.name AS pizzeria_name
  FROM person p
  INNER JOIN person_order pv ON p.id = pv.person_id
  INNER JOIN menu ON menu.id = pv.menu_id
  INNER JOIN pizzeria p2 ON p2.id = menu.pizzeria_id
  WHERE p.gender = 'female'
  EXCEPT SELECT p2.name
  FROM person p
  INNER JOIN person_order pv ON p.id = pv.person_id
  INNER JOIN menu ON menu.id = pv.menu_id
  INNER JOIN pizzeria p2 ON p2.id = menu.pizzeria_id
  WHERE p.gender = 'male')
UNION
  (SELECT p2.name
  FROM person p
  INNER JOIN person_order pv ON p.id = pv.person_id
  INNER JOIN menu ON menu.id = pv.menu_id
  INNER JOIN pizzeria p2 ON p2.id = menu.pizzeria_id
  WHERE p.gender = 'male'
  EXCEPT SELECT p2.name
  FROM person p
  INNER JOIN person_order pv ON p.id = pv.person_id
  INNER JOIN menu ON menu.id = pv.menu_id
  INNER JOIN pizzeria p2 ON p2.id = menu.pizzeria_id
  WHERE p.gender = 'female')
ORDER BY 1

/*
--ВНИМАНИЕ!!! ТУТ НЕКОРРЕКТНАЯ ВЫДАЧА В ЗАДАНИИ. ПОСКОЛЬКУ У НАС НЕТ ПИЦЦЕРИЙ КОТОРЫЕ НЕ ПОСЕШАЛИ
--ТОЛЬКО ЖЕНЩИНЫ ИЛИ ТОЛЬКО МУЖЧИНЫ ТО ВЫДАЧА БУДЕТ НУЛЕВАЯ.
--А ПО ЗАДАНИЮ ВЫДАЧА НЕ НУЛЕВАЯ
--ВОТ ЗАПРОС ДЛЯ ПРОВЕРКИ ПО ПОЛУ:

SELECT pizzeria.name AS pizzeria_name, p.gender
FROM public.person_visits pv
JOIN person p ON pv.person_id = p.id 
JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY pizzeria_name, gender
order by pizzeria_name


-- Пиццерии, посещённые только мужчинами
SELECT pizzeria.name AS pizzeria_name
FROM public.person_visits pv
JOIN person p ON pv.person_id = p.id 
JOIN pizzeria ON pizzeria_id = pizzeria.id

GROUP BY pizzeria.name
HAVING SUM(CASE WHEN gender = 'male' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN gender = 'female' THEN 1 ELSE 0 END) = 0

UNION

-- Пиццерии, посещённые только женщинами
SELECT pizzeria.name AS pizzeria_name
FROM public.person_visits pv
JOIN person p ON pv.person_id = p.id 
JOIN pizzeria ON pizzeria_id = pizzeria.id
GROUP BY pizzeria.name
HAVING SUM(CASE WHEN gender = 'female' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN gender = 'male' THEN 1 ELSE 0 END) = 0
ORDER BY pizzeria_name;
*/