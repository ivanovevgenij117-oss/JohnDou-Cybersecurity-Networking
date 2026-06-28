SELECT CONCAT(name, '(age: ', age::TEXT, ', gender: ''', gender::TEXT, ''', address: ''', address::TEXT, '''') AS person_information FROM public.person
ORDER BY person_information ASC 