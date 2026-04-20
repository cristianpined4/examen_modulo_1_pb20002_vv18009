-- Tabla de rangos 
CREATE TABLE rangos_investigador (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Investigadores
CREATE TABLE investigadores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    rango_id INT NOT NULL
);

-- Laboratorios
CREATE TABLE laboratorios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

-- Equipos
CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    laboratorio_id INT NOT NULL
);

-- Reservas
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    investigador_id INT NOT NULL,
    laboratorio_id INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

-- Relación reserva - equipos (
CREATE TABLE reserva_equipos (
    id SERIAL PRIMARY KEY,
    reserva_id INT NOT NULL,
    equipo_id INT NOT NULL
);

-- Auditoría 
CREATE TABLE auditoria (
    id SERIAL PRIMARY KEY,
    tabla_afectada VARCHAR(50),
    operacion VARCHAR(20),
    usuario VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);