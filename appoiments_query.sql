CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    barber_id INT REFERENCES barbers(id) ON DELETE CASCADE,
    specialty_id INT REFERENCES specialties(id) ON DELETE CASCADE,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendado',  -- Puede ser Agendado, Completado, Cancelado
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO appointments (
    user_id,
    barber_id,
    specialty_id,
    appointment_date
) VALUES (
    1,  -- ID del usuario
    1,  -- ID del barbero
    1,  -- ID de la especialidad
    '2024-10-30 10:00:00'  -- Fecha y hora de la cita
);

UPDATE appointments
SET status = 'Cancelado', updated_at = CURRENT_TIMESTAMP
WHERE id = 1;  -- ID de la cita que deseas cancelar


SELECT 
    a.id AS appointment_id,
    u.first_name AS client_name,
    b.first_name AS barber_first_name,
    b.last_name AS barber_last_name,
    s.specialties_name AS specialty_name,
    a.appointment_date,
    a.status
FROM 
    appointments a
JOIN 
    users u ON a.user_id = u.id
JOIN 
    barbers b ON a.barber_id = b.id
JOIN 
    specialties s ON a.specialty_id = s.id
ORDER BY 
    a.appointment_date;
