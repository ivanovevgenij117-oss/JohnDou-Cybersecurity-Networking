--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. установка режима строгой изоляции
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

--сессия 2. установка режима строгой изоляции
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

--сессия 1. суммируем данные рейтинга 21.9
SELECT SUM(rating) FROM pizzeria;

--сессия 2. вставляем новые данные
INSERT INTO pizzeria VALUES (11, 'Kazan Pizza 2', 4);

--сессия 2. делаем коммит
COMMIT;

--сессия 1. суммируем данные рейтинга 26.9
SELECT SUM(rating) FROM pizzeria;

--сессия 1. коммит
COMMIT;

--сессия 1. суммируем данные рейтинга 30.9
SELECT SUM(rating) FROM pizzeria;

--сессия 2. суммируем данные рейтинга 30.9
SELECT SUM(rating) FROM pizzeria;