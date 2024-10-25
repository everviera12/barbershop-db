CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    street VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    municipality VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip VARCHAR(10) NOT NULL CHECK (zip ~ '^[0-9]{5}$'),  -- 5-digit postal code
    profile_picture VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10) NOT NULL
);

INSERT INTO Users (
    first_name,
    last_name,
    email,
    phone,
    password,
    street,
    neighborhood,
    municipality,
    state,
    zip,
    profile_picture,
    birth_date,
    gender
) VALUES (
    'Victor',
    'Viera Ramirez',
    'ing_victor@gmail.com',
    '8122134521',
    'hashed_password', 
    'El paso 5407',
    'Rivera Oriental',
    'Mochis',
    'Sinaloa',
    '67123',
    'https://avatars.githubusercontent.com/u/112356399?s=400&u=b50887cce06551e7c1786e9a5b9ad81b3913de72&v=4',
    '2000-11-27',
    'Male'
);
