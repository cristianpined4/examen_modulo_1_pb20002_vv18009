-- investigadores → rangos
ALTER TABLE investigadores
ADD CONSTRAINT fk_investigador_rango
FOREIGN KEY (rango_id) REFERENCES rangos_investigador(id);

-- equipos → laboratorios
ALTER TABLE equipos
ADD CONSTRAINT fk_equipo_laboratorio
FOREIGN KEY (laboratorio_id) REFERENCES laboratorios(id)
ON DELETE CASCADE;

-- reservas → investigadores
ALTER TABLE reservas
ADD CONSTRAINT fk_reserva_investigador
FOREIGN KEY (investigador_id) REFERENCES investigadores(id);

-- reservas → laboratorios
ALTER TABLE reservas
ADD CONSTRAINT fk_reserva_laboratorio
FOREIGN KEY (laboratorio_id) REFERENCES laboratorios(id);

-- reserva_equipos → reservas
ALTER TABLE reserva_equipos
ADD CONSTRAINT fk_reserva_equipos_reserva
FOREIGN KEY (reserva_id) REFERENCES reservas(id)
ON DELETE CASCADE;

-- reserva_equipos → equipos
ALTER TABLE reserva_equipos
ADD CONSTRAINT fk_reserva_equipos_equipo
FOREIGN KEY (equipo_id) REFERENCES equipos(id);

-- Nivel de bioseguridad válido
ALTER TABLE laboratorios
ADD CONSTRAINT chk_bioseguridad
CHECK (nivel_bioseguridad BETWEEN 1 AND 4);

-- Estado válido de equipo
ALTER TABLE equipos
ADD CONSTRAINT chk_estado_equipo
CHECK (estado IN ('disponible', 'mantenimiento', 'fuera_servicio'));

-- Fechas coherentes
ALTER TABLE reservas
ADD CONSTRAINT chk_fechas
CHECK (fecha_fin > fecha_inicio);

-- Necesario para rangos
CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE reservas
ADD CONSTRAINT no_solapamiento_reservas
EXCLUDE USING GIST (
    investigador_id WITH =,
    tsrange(fecha_inicio, fecha_fin) WITH &&
);

-- Búsquedas por fecha
CREATE INDEX idx_reservas_fecha
ON reservas (fecha_inicio, fecha_fin);

-- Búsqueda por laboratorio
CREATE INDEX idx_reservas_laboratorio
ON reservas (laboratorio_id);