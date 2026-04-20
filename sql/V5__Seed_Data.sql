-- llenar la tabla rangos_investigador con datos de ejemplo
INSERT INTO rangos_investigador (nombre) VALUES
('Junior'),
('Senior'),
('Director');

-- llenar la tabla investigadores con datos de ejemplo
INSERT INTO investigadores (nombre, email, rango_id) VALUES
('Ana Lopez', 'ana@test.com', 1),
('Carlos Ruiz', 'carlos@test.com', 2),
('Maria Perez', 'maria@test.com', 3),
('Luis Gomez', 'luis@test.com', 1),
('Elena Torres', 'elena@test.com', 2);

-- llenar la tabla laboratorios con datos de ejemplo
INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES
('Lab A', 1, 10),
('Lab B', 2, 15),
('Lab C', 3, 8),
('Lab D', 4, 5),
('Lab E', 2, 20);

-- llenar la tabla equipos con datos de ejemplo
INSERT INTO equipos (nombre, estado, laboratorio_id, ultima_revision) VALUES
('Microscopio 1', 'disponible', 1, CURRENT_DATE),
('Centrifuga', 'mantenimiento', 2, CURRENT_DATE),
('Espectrometro', 'disponible', 3, CURRENT_DATE),
('Analizador ADN', 'disponible', 4, CURRENT_DATE),
('Incubadora', 'fuera_servicio', 5, CURRENT_DATE);

-- Director en laboratorio nivel 4 (válido)
INSERT INTO reservas (investigador_id, laboratorio_id, fecha_inicio, fecha_fin)
VALUES (3, 4, '2026-04-20 08:00', '2026-04-20 10:00');

-- Reserva normal
INSERT INTO reservas (investigador_id, laboratorio_id, fecha_inicio, fecha_fin)
VALUES (1, 1, '2026-04-20 10:30', '2026-04-20 12:00');

-- Reserva con equipo en mantenimiento
INSERT INTO reserva_equipos (reserva_id, equipo_id) VALUES
(1, 4),
(2, 1);