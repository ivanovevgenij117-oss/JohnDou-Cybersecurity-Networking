create unique index if not exists idx_menu_unique on menu (pizzeria_id, pizza_name);

SET enable_seqscan = OFF; 
EXPLAIN ANALYZE

SELECT pizzeria_id, pizza_name FROM menu
where pizzeria_id = 1 and pizza_name = 'pepperoni pizza'
