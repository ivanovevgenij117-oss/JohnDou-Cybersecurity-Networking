WITH max_id AS (
    SELECT MAX(id) AS max_id FROM person_order
)
INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT 
    max_id.max_id + ROW_NUMBER() OVER (),  -- генерируем уникальные идентификаторы
    person.id,                            -- идентификатор клиента
    (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),  -- идентификатор пиццы
    '2022-02-25'                         -- дата заказа
FROM person
CROSS JOIN max_id;