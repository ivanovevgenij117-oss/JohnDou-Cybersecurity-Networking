--создаем функцию
CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO person_audit(type_event, row_id, name, age, gender, address) VALUES ('U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--триггер
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
CREATE TRIGGER trg_person_update_audit
AFTER UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

--тестовая вставка
UPDATE person SET name = 'Bulat' WHERE id = 10; 
UPDATE person SET name = 'Damir' WHERE id = 10;