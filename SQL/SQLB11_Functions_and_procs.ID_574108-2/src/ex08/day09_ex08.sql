CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer DEFAULT 10)
RETURNS TABLE (num integer)
AS $$
	WITH RECURSIVE fib(a,b)	AS(
		SELECT 0, 1
		UNION ALL
		SELECT b, a+b FROM fib
		WHERE b < pstop
	)
	SELECT a FROM fib;
$$ LANGUAGE SQL;

--тестовый вывод
select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
