SELECT 
	address,
	ROUND(MAX(age)::numeric-(MIN(age)::numeric/max(age)::numeric), 2)::float AS formula,
	ROUND(AVG(age), 2)::float AS average,
	ROUND(MAX(age)::numeric-(MIN(age)::numeric/max(age)::numeric), 2) > ROUND(AVG(age), 2)::float AS comparsion
FROM public.person
GROUP BY address
ORDER BY address ASC 