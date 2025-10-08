CREATE OR REPLACE FUNCTION recalcular_idx()
RETURNS TRIGGER AS $$
BEGIN
    NEW.IDX := ((NEW.IDH_EDUCACAO * NEW.IDH_EDUCACAO) * NEW.IDH_LONGEVIDADE) / NEW.IDH_GERAL;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_recalcular_idx
BEFORE UPDATE OF IDH_Geral, IDH_Longevidade, IDH_Educacao
ON Indice
FOR EACH ROW
EXECUTE FUNCTION recalcular_idx();

CREATE OR REPLACE FUNCTION alimentar_auditoria_idx()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria (
        data_ateracao,
        valor_antigo_idx,
        valor_novo_idx,
        diferenca_idx,
        codMunicipio,
        ano_indice
    )
    VALUES (
        NOW(),
        OLD.IDX,
        NEW.IDX,
        ABS(NEW.IDX - OLD.IDX),
        NEW.CodMunicipio,
        NEW.Ano
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_idx
AFTER UPDATE OF IDX
ON Indice
FOR EACH ROW
EXECUTE FUNCTION alimentar_auditoria_idx();

CREATE FUNCTION media_diferencas_idx_hoje()
RETURNS DECIMAL(8, 3) AS $$
BEGIN
	RETURN (SELECT ROUND(AVG(diferenca_idx), 3) FROM auditoria WHERE DATE(auditoria.data_ateracao) = CURRENT_DATE);	
END;
$$ LANGUAGE plpgsql;
