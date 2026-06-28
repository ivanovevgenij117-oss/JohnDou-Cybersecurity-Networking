CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr numeric[])
RETURNS numeric AS $$
	SELECT MIN(val) FROM UNNEST(arr) AS val; --преобразуем массив в виртуальную таблиц и применяем к ней MIN
$$ LANGUAGE SQL;

--тестовый вывод
SELECT * FROM func_minimum(1,2,3, -6, 0.5);
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);

