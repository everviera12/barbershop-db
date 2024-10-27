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
    zip VARCHAR(10) NOT NULL CHECK (zip ~ '^[0-9]{5}$'), -- 5-digit postal code
    profile_picture VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10) NOT NULL
);

SELECT * FROM information_schema.columns WHERE table_name = 'users';

SELECT kcu.column_name, tc.constraint_name
FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
WHERE
    tc.constraint_type = 'UNIQUE'
    AND tc.table_name = 'users';

SELECT * FROM users;

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

CALL insert_user (
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