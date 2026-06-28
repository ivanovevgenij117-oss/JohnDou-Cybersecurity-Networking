--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. Установка сериализуемого уровня изоляции. Транзакции идут строго по очереди
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

--сессия 2. Установка сериализуемого уровня изоляции. Транзакции идут строго по очереди
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

--сессия 1. смотрим БД. рейтинг 3.6
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2.Вносим изменения в рейтинг. 3.0
UPDATE pizzeria SET rating = 3.0 WHERE name = 'Pizza Hut';

--сессия 2. коммит
COMMIT;

--сессия 1. Смотрим БД. рейтинг не поменялся 3.6
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 1. коммит
COMMIT;

--сессия 1. Смотрим БД. рейтинг поменялся. 3.0
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2. Смотрим БД. рейтинг 3.0
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
