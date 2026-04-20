CREATE OR REPLACE FUNCTION validar_reserva_nivel4()
RETURNS TRIGGER AS $$
DECLARE
    nivel INT;
    rango_nombre VARCHAR;
BEGIN
    -- Obtener nivel del laboratorio
    SELECT nivel_bioseguridad INTO nivel
    FROM laboratorios
    WHERE id = NEW.laboratorio_id;

    -- Obtener rango del investigador
    SELECT r.nombre INTO rango_nombre
    FROM investigadores i
    JOIN rangos_investigador r ON i.rango_id = r.id
    WHERE i.id = NEW.investigador_id;

    -- Validación
    IF nivel = 4 AND rango_nombre <> 'Director' THEN
        RAISE EXCEPTION 'Solo Directores pueden reservar laboratorios nivel 4';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_reserva
BEFORE INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION validar_reserva_nivel4();

CREATE OR REPLACE FUNCTION registrar_auditoria()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, usuario)
    VALUES (TG_TABLE_NAME, TG_OP, current_user);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_auditoria_reservas
AFTER INSERT OR UPDATE OR DELETE ON reservas
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria();

CREATE TRIGGER trg_auditoria_equipos
AFTER UPDATE ON equipos
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria();