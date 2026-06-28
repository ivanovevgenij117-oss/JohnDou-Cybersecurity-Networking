--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 2. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 1. Чтение БД. рейтинг 4
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2. Обновление данных в БД
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

--сессия 2. коммит
COMMIT;

--сессия 1. проверяем БД. данные рейтинга изменились на 3.6
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 1. коммит
COMMIT;

--сессия 1. проверяем БД. данные рейтинга 3.6
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2. проверяем БД. данные рейтинга 3.6
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
