CREATE TABLE specialties (
    id SERIAL PRIMARY KEY,
    specialties_name VARCHAR(100) NOT NULL UNIQUE  
);

INSERT INTO specialties (name) VALUES
('Corte de cabello'),
('Afeitado'),
('Barba y Bigote'),
('Cortes de tendencia'),
('Peinados'),
('Coloración'),
('Corte de cabello para niños'),
('Corte de cabello femenino'),
('Estilo de cabello'),
('Tratamientos capilares'),
('Extensiones de cabello'),
('Ondas y rizos'),
('Tintes y mechas'),
('Cuidado de la barba'),
('Corte de cabello a máquina'),
('Corte de cabello clásico'),
('Corte de cabello moderno');


-- sp to insert new specialties_name
CREATE OR REPLACE PROCEDURE insert_specialty(specialty_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO specialties (specialties_name)
    VALUES (specialty_name)
    ON CONFLICT (specialties_name) DO NOTHING;
END;
$$;


-- sp to update specialties
CREATE OR REPLACE PROCEDURE update_specialty(specialty_id INT, new_specialty_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE specialties
    SET specialties_name = new_specialty_name
    WHERE id = specialty_id;
END;
$$;


-- sp to delete specialties
CREATE OR REPLACE PROCEDURE delete_specialty(specialty_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM specialties
    WHERE id = specialty_id;
END;
$$;
