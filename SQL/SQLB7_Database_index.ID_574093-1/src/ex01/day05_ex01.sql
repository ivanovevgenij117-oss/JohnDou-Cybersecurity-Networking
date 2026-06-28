SET enable_seqscan = OFF; 
EXPLAIN ANALYZE

SELECT pizza_name, name as pizzeria_name FROM menu
Join pizzeria ON menu.pizzeria_id = pizzeria.id
