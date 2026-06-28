WITH RECURSIVE travel_path AS(
	SELECT
	city_to AS current_city,
	CAST ('{a,' || city_to AS TEXT) AS path,
	cost AS total_cost,
	2 AS visited_count,
	CAST ('{a,' || city_to || ',' AS TEXT) AS visited_nodes
	FROM public.distances
	WHERE  city_from = 'a'

UNION ALL

	SELECT
		distances.city_to,
		travel_path.path || ',' || distances.city_to,
		travel_path.total_cost + distances.cost,
		travel_path.visited_count +1,
		travel_path.visited_nodes || distances.city_to ||',' 
	FROM travel_path
	JOIN distances ON travel_path.current_city = distances.city_from
	WHERE travel_path.visited_count < 4 
	AND travel_path.visited_nodes NOT LIKE '%' || distances.city_to || '%'
)
SELECT 
	travel_path.total_cost + distances.cost AS total_cost,
	path || ',a}' AS tour

FROM travel_path
	JOIN distances ON travel_path.current_city = distances.city_from
	WHERE visited_count = 4 AND distances.city_to = 'a'

	ORDER BY total_cost ASC, tour ASC