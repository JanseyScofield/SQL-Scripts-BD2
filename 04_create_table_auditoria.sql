CREATE TABLE auditoria(
	id DECIMAL(6) NOT NULL,
	data_ateracao DATE NOT NULL,
	valor_antigo_idx DECIMAL(8,3) NOT NULL,
	valor_novo_idx DECIMAL(8,3) NOT NULL,
	diferenca_idx DECIMAL(8,3) NOT NULL,
	codMunicipio DECIMAL NOT NULL,
	ano_indice DECIMAL NOT NULL,
	CONSTRAINT pk_auditoria PRIMARY KEY (id),
	CONSTRAINT fk_auditoria_pk_municipio FOREIGN KEY (codMunicipio) REFERENCES Municipio (CodMunicipio)
);
