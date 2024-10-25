CREATE TABLE barbers_specialties (
    barber_id INT REFERENCES barbers(id) ON DELETE CASCADE,
    specialty_id INT REFERENCES specialties(id) ON DELETE CASCADE,
    PRIMARY KEY (barber_id, specialty_id) 
);

INSERT INTO barbers_specialties (barber_id, specialty_id) VALUES
(1, 1), 
(1, 2), 
(1, 3); 

SELECT 
    b.first_name,
    b.last_name,
    s.specialties_name AS specialty_name
FROM 
    barbers b
JOIN 
    barbers_specialties bs ON b.id = bs.barber_id
JOIN 
    specialties s ON bs.specialty_id = s.id
WHERE 
    b.id = 1;  -- Cambia el ID por el del barbero que desees consultar