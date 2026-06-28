--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 2. Установка уровеня изоляции транзакции.  Чтение только подтвержденных изменений
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--сессия 1. Внесение изменнеий в БД
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

--сессия 2. Внесение изменнеий в БД. Сессия "зависает", ждет коммита в сессии 1
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

--сессия 1. 
COMMIT; --сессия 2 отвисает

--сессия 2. коммит
COMMIT;

--сессия 1. Проверяем БД. Коммит в сессии 1 пропал
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2. Проверяем БД. Коммит в сессии 2 сохранился (3.6)
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

