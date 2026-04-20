-- Fecha de última revisión
ALTER TABLE equipos
ADD COLUMN ultima_revision DATE;

-- Responsable del mantenimiento
ALTER TABLE equipos
ADD COLUMN responsable_mantenimiento INT;

-- FK opcional hacia investigadores
ALTER TABLE equipos
ADD CONSTRAINT fk_responsable_mantenimiento
FOREIGN KEY (responsable_mantenimiento)
REFERENCES investigadores(id)
ON DELETE SET NULL;

-- Validación para evitar reservas de equipos en mantenimiento
CREATE OR REPLACE FUNCTION validar_equipo_disponible()
RETURNS TRIGGER AS $$
DECLARE
    estado_equipo VARCHAR;
BEGIN
    SELECT estado INTO estado_equipo
    FROM equipos
    WHERE id = NEW.equipo_id;

    IF estado_equipo <> 'disponible' THEN
        RAISE EXCEPTION 'El equipo no está disponible para reserva';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- aplicacion del trigger para validar el estado del equipo antes de reservarlo
CREATE TRIGGER trg_validar_equipo
BEFORE INSERT ON reserva_equipos
FOR EACH ROW
EXECUTE FUNCTION validar_equipo_disponible();