CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
	user_name VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    street VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,		
    state VARCHAR(100) NOT NULL,
    zip VARCHAR(10) NOT NULL CHECK (zip ~ '^[0-9]{5}$'),  -- 5-digit postal code
    profile_picture VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10) NOT NULL
);


-- info of schema
SELECT * FROM information_schema.columns WHERE table_name = 'users';


-- what columns have unique type
SELECT
    kcu.column_name,
    tc.constraint_name
FROM
    information_schema.table_constraints tc
JOIN
    information_schema.key_column_usage kcu
      ON tc.constraint_name = kcu.constraint_name
WHERE
    tc.constraint_type = 'UNIQUE'
    AND tc.table_name = 'users';


-- get all users
SELECT * FROM users;

-- sp for insert users
CREATE OR REPLACE PROCEDURE insert_user(
    _first_name VARCHAR(50),
    _last_name VARCHAR(50),
    _email VARCHAR(100),
    _phone VARCHAR(15),
    _password VARCHAR(255),
    _street VARCHAR(100),
    _neighborhood VARCHAR(100),
    _city VARCHAR(100),
    _state VARCHAR(100),
    _zip VARCHAR(10),
    _profile_picture VARCHAR(255),
    _birth_date DATE,
    _gender VARCHAR(10),
    _user_name VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO users (
        first_name,
        last_name,
        email,
        phone,
        password,
        street,
        neighborhood,
        city,
        state,
        zip,
        profile_picture,
        birth_date,
        gender,
        user_name
    ) VALUES (
        _first_name,
        _last_name,
        _email,
        _phone,
        _password,
        _street,
        _neighborhood,
        _city,
        _state,
        _zip,
        _profile_picture,
        _birth_date,
        _gender,
        _user_name
    );
    
    RAISE NOTICE 'User inserted: % %', _first_name, _last_name;
END;
$$;


-- sp to delete user
CREATE OR REPLACE PROCEDURE delete_user(
    _user_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM users
    WHERE id = _user_id;

    IF FOUND THEN
        RAISE NOTICE 'User with ID % deleted successfully.', _user_id;
    ELSE
        RAISE NOTICE 'No user found with ID %.', _user_id;
    END IF;
END;
$$;

-- sp for update users
CREATE OR REPLACE PROCEDURE update_user(
    p_id INTEGER,
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50),
    p_email VARCHAR(100),
    p_phone VARCHAR(15),
    p_user_name VARCHAR(100),
    p_password VARCHAR(255),  -- Agregado el campo de contraseña
    p_street VARCHAR(100),
    p_neighborhood VARCHAR(100),
    p_city VARCHAR(100),
    p_state VARCHAR(100),
    p_zip VARCHAR(10),
    p_profile_picture VARCHAR(255),
    p_birth_date DATE,
    p_gender VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE users
    SET 
        first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone = p_phone,
        user_name = p_user_name,
        password = p_password,  -- Actualizando la contraseña
        street = p_street,
        neighborhood = p_neighborhood,
        city = p_city,
        state = p_state,
        zip = p_zip,
        profile_picture = p_profile_picture,
        birth_date = p_birth_date,
        gender = p_gender
    WHERE id = p_id;

    -- Opción: Lanzar un error si no se actualizó ningún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_id;
    END IF;
END;
$$;







-- CRUD funcctions
CALL insert_user(
    'Ana Maria',
    'Gonzalez Perez',
    'ana.gonzalez@example.com',
    '5551234567',
    'hashed_password_123',
    'Lomas Musrtbas 123',
    'Centro',
    'Monterrey',
    'Nuevo Leon',
    '64000',
    'https://avatars.githubusercontent.com/u/123456?v=4',
    '1995-05-15',
    'Female',
    'anagp95'
);

CALL delete_user(1);
