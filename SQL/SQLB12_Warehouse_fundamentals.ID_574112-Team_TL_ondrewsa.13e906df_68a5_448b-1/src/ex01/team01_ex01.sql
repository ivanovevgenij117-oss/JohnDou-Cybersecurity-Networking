INSERT INTO currency VALUES (100, 'EUR', 0.85, '2022-01-01 13:29');
INSERT INTO currency VALUES (100, 'EUR', 0.79, '2022-01-08 13:29');

SELECT
    user_data.name,
    user_data.lastname,
    user_data.currency_name,
    (user_data.money * user_data.rate_to_usd)::FLOAT AS currency_in_usd
FROM (
    SELECT
        COALESCE(usr.name, 'not defined') AS name,
        COALESCE(usr.lastname, 'not defined') AS lastname,
        currency_info.name AS currency_name,
        bal.money,
        COALESCE(
            (SELECT rate_to_usd FROM currency curr1 WHERE curr1.id = bal.currency_id AND curr1.updated < bal.updated ORDER BY curr1.updated DESC LIMIT 1),
            (SELECT rate_to_usd FROM currency curr2 WHERE curr2.id = bal.currency_id AND curr2.updated > bal.updated ORDER BY curr2.updated ASC LIMIT 1)
        ) AS rate_to_usd
    FROM balance bal
    INNER JOIN (SELECT id, name FROM currency GROUP BY id, name) AS currency_info ON currency_info.id = bal.currency_id
    LEFT JOIN "user" usr ON usr.id = bal.user_id
) AS user_data
ORDER BY user_data.name DESC, user_data.lastname ASC, user_data.currency_name ASC;