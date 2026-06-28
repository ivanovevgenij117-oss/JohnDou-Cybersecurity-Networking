--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 2. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 1. суммируем данные рейтинга 21.9
SELECT SUM(rating) FROM pizzeria;

--сессия 2. вставляем новые данные
INSERT INTO pizzeria VALUES (10, 'Kazan Pizza', 5);

--сессия 2. делаем коммит
COMMIT;

--сессия 1. суммируем данные рейтинга 26.9
SELECT SUM(rating) FROM pizzeria;

--сессия 1. коммит
COMMIT;

--сессия 1. суммируем данные рейтинга 26.9
SELECT SUM(rating) FROM pizzeria;

--сессия 2. суммируем данные рейтинга 26.9
SELECT SUM(rating) FROM pizzeria;
