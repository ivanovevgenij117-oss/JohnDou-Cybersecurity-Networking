DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

CREATE OR REPLACE FUNCTION fnc_persons(p_gender varchar DEFAULT 'female')
RETURNS TABLE(
	id bigint,
	name varchar,
	age integer,
	gender varchar,
	address varchar
) AS $$
	SELECT id, name, age, gender, address FROM person WHERE gender = p_gender;
$$ LANGUAGE SQL;


--тестовый вывод
--SELECT * FROM fnc_persons('male');
SELECT * FROM fnc_persons();