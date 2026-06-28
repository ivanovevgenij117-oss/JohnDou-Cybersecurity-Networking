--DROP TABLE person_audit;
--создаем таблицу для хранения лога/аудита
CREATE TABLE IF NOT EXISTS person_audit(
	created timestamp with time zone NOT NULL DEFAULT now(),
	type_event char(1) NOT NULL DEFAULT 'I',
	row_id bigint NOT NULL,
	name varchar,
	age integer,
	gender varchar,
	address varchar,
	CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'U', 'D'))
);

--создаем функцию
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO person_audit(type_event, row_id, name, age, gender, address) VALUES ('I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--триггер
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

--тестовая вставка
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');