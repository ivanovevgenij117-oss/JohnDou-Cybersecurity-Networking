--сессия 1. запуск транзакций без коммита
mydb=> BEGIN;

--сессия 1. вносим измениния в БД
mydb=*> UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';

--сессия 2. смотрим БД. видно что коммита еще не было и БД находится в исходном состоянии, т.е рейтинг 4.6
mydb=> SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

--сессия 1. делаем коммит
mydb=*> COMMIT;

--сессия 2. Смотрим БД. Видим что рейтинг обновился. Теперь он 5
mydb=> SELECT * FROM pizzeria WHERE name = 'Pizza Hut';