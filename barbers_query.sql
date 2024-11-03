CREATE TABLE barbers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    experience_years INTEGER NOT NULL,  
    street VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    municipality VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip VARCHAR(10) NOT NULL CHECK (zip ~ '^[0-9]{5}$'), 
    profile_picture VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status BOOLEAN DEFAULT TRUE NOT NULL,  
    working_hours JSONB NOT NULL          
);

-- sp to insert barber
CREATE OR REPLACE PROCEDURE insert_barber(
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    password VARCHAR,
    experience_years INTEGER,
    street VARCHAR,
    neighborhood VARCHAR,
    municipality VARCHAR,
    state VARCHAR,
    zip VARCHAR,
    profile_picture VARCHAR,
    working_hours JSONB
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO barbers (first_name, last_name, email, phone, password, experience_years, 
                          street, neighborhood, municipality, state, zip, profile_picture, 
                          working_hours)
    VALUES (first_name, last_name, email, phone, password, experience_years, 
            street, neighborhood, municipality, state, zip, profile_picture, 
            working_hours);
END;
$$;


-- sp to update barber
CREATE OR REPLACE PROCEDURE update_barber(
    barber_id INTEGER,
    first_name VARCHAR DEFAULT NULL,
    last_name VARCHAR DEFAULT NULL,
    email VARCHAR DEFAULT NULL,
    phone VARCHAR DEFAULT NULL,
    password VARCHAR DEFAULT NULL,
    experience_years INTEGER DEFAULT NULL,
    street VARCHAR DEFAULT NULL,
    neighborhood VARCHAR DEFAULT NULL,
    municipality VARCHAR DEFAULT NULL,
    state VARCHAR DEFAULT NULL,
    zip VARCHAR DEFAULT NULL,
    profile_picture VARCHAR DEFAULT NULL,
    working_hours JSONB DEFAULT NULL
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE barbers
    SET first_name = COALESCE(first_name, first_name),
        last_name = COALESCE(last_name, last_name),
        email = COALESCE(email, email),
        phone = COALESCE(phone, phone),
        password = COALESCE(password, password),
        experience_years = COALESCE(experience_years, experience_years),
        street = COALESCE(street, street),
        neighborhood = COALESCE(neighborhood, neighborhood),
        municipality = COALESCE(municipality, municipality),
        state = COALESCE(state, state),
        zip = COALESCE(zip, zip),
        profile_picture = COALESCE(profile_picture, profile_picture),
        working_hours = COALESCE(working_hours, working_hours)
    WHERE id = barber_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Barber with ID % not found', barber_id;
    END IF;
END;
$$;


-- sp to delete barber
CREATE OR REPLACE PROCEDURE delete_barber(
    barber_id INTEGER
)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM barbers
    WHERE id = barber_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Barber with ID % not found', barber_id;
    END IF;
END;
$$;
