DROP TABLE IF EXISTS distances CASCADE;


-- Создаем таблицу distances
CREATE TABLE distances (
    city_from CHAR(1),
    city_to CHAR(1),
    cost INTEGER
);

INSERT INTO distances VALUES
('b', 'a', 10),
('a', 'b', 10),
('c', 'a', 15),
('c', 'b', 35),
('a', 'c', 15),
('b', 'c', 35),
('d', 'a', 20),
('d', 'b', 25),
('d', 'c', 30),
('a', 'd', 20),
('b', 'd', 25),
('c', 'd', 30);

SELECT
	total_cost,
	tour
	FROM(
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
	path || ',a}' AS tour,
	RANK() OVER (ORDER BY (travel_path.total_cost + distances.cost) ASC) AS rnk

FROM travel_path
	JOIN distances ON travel_path.current_city = distances.city_from
	WHERE visited_count = 4 AND distances.city_to = 'a') AS final
	WHERE rnk = 1
	
	ORDER BY total_cost ASC, tour ASC