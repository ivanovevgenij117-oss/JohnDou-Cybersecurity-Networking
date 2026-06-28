create index if not exists idx_person_name ON person (upper(name));

SET enable_seqscan = OFF; 
EXPLAIN ANALYZE

SELECT * FROM person Where Upper(name) = 'IRINA'