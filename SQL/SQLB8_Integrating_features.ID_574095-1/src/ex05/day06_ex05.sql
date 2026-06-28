COMMENT ON TABLE person_discounts IS '';

COMMENT ON COLUMN person_discounts.id IS 'первичный ключ';
COMMENT ON COLUMN person_discounts.person_id IS 'идентификатор клиента';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'идентификатор пиццерии';
COMMENT ON COLUMN person_discounts.discount IS 'размер скидки';