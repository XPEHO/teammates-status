INSERT INTO public.entity_log(
entity_log_creation_date, entity_log_inactivation_date)
VALUES 
	('2023-02-20', '2050-02-20');		   

INSERT INTO public.locations(
	location_name, location_adress, location_entity_log_id, location_is_active)
	VALUES ('Leroy merlin', 'Rue de Versailles, 59650 Villeneuve-d''Ascq', 1, true),
		   ('XPEHO', '1 Boulevard de Valmy, 59650 Villeneuve d Ascq', 1, true),
		   ('ADEO', '135 Rue Sadi Carnot, 59790 Ronchin', 1, true),
		   ('NADEO', '40 Rue de la voiture, 59000 Lille', 1, true);

-- INSERT OWNERS
