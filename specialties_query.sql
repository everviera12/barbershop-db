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