SELECT 
	COALESCE("user".name, 'not defined') AS name,
	COALESCE(lastname, 'not defined') AS lastname,
	type,
	SUM(balance.money) AS volume,
	COALESCE(c.name, 'not defined') AS currency_name,
	COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd,
	(COALESCE(SUM(balance.money) * c.rate_to_usd, SUM(balance.money)))::float AS total_volume_in_usd
FROM public.balance
full join public.user on balance.user_id = "user".id
left join (SELECT 
				id, 
				name, 
				rate_to_usd,
				ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated DESC) as rn --сортируем группами по валюте
			FROM currency
		) AS c ON balance.currency_id = c.id AND c.rn = 1
GROUP BY 
	"user".name,
	lastname,
	type,
	c.name,
	c.rate_to_usd
ORDER BY name DESC, lastname ASC, type ASC