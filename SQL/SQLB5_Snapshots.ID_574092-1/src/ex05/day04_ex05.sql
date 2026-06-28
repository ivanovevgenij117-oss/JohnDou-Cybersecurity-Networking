CREATE OR REPLACE VIEW v_price_with_discount AS
(
SELECT

	name,
	pizza_name,
	price,
	CAST ((price - price * 0.1) AS INTEGER) AS discount_price --приводим к целочисленному резальтат вычислений

FROM public.person_order

JOIN person ON person_order.person_id = person.id
JOIN menu ON menu_id = menu.id

ORDER BY name ASC, pizza_name ASC )