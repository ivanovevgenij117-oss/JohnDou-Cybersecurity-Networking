--создаем последовательность
CREATE SEQUENCE IF NOT EXISTS seq_person_discounts START WITH 1;

--устанавливаем стартовое значение исходя из количества существующих
SELECT setval('seq_person_discounts', (SELECT COUNT(*) FROM person_discounts));

--привязываем последовательность к колонке id
ALTER TABLE person_discounts ALTER COLUMN id SET DEFAULT nextval('seq_person_discounts');