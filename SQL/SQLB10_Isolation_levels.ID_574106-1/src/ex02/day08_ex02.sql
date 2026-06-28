--сессия 1. начало транзакции
BEGIN;

--сессия 2. начало транзакции
BEGIN;

--сессия 1. установка режима строгой изоляции
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

--сессия 2. установка режима строгой изоляции
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

--сессия 1. Внесение изменений в БД
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

--сессия 2. попытка внесений в БД. сессия подвисает
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

--сессия 1. коммит. вторая сессия отвисает и выдает ошибку
COMMIT;

--сессия 2. не выполняется - происходит отмена сессии rollback
COMMIT;

--сессия 1. Проверка БД. Измения в первой сессии прошли и рейтинг теперь 4.
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 2. Проверка БД. Изменения во второй сесси не прошли и рейтинг остался из первой сессии - 4.
mydb=> SELECT * FROM pizzeria WHERE name = 'Pizza Hut';