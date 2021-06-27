/*Drops */
DROP TABLE ST1_MARCA;
DROP TABLE ST2_MARCA;
DROP TABLE ST3_MARCA;
DROP TABLE DIM_MARCA;
DROP TABLE METADADO_MARCA;

/* Satge 1 MARCA */
/*Extração dos dados*/

CREATE TABLE ST1_MARCA
(
    EMPRESA INTEGER, 
	MARCA VARCHAR2(6), 
	EMPREENDIMENTO VARCHAR2(31), 
	CLIENTE VARCHAR2(12), 
	REGIONAL VARCHAR2(9), 
	OBRA NUMBER(*,0), 
	BLOCO NUMBER(*,0), 
	UNIDADE NUMBER(*,0), 
	DT_VENDA DATE, 
	DT_CHAVES DATE, 
	CARTEIRA NUMBER, 
	SALDO_DEVEDOR NUMBER, 
	DT_BASE DATE, 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2), 
	VALOR_PAGO NUMBER(12,2), 
	STATUS VARCHAR2(1), 
	DT_RENEGOCIACAO VARCHAR2(1), 
	DESCONTO VARCHAR2(1), 
	VAGA VARCHAR2(1), 
	VGV NUMBER
);

/*Passo de coleta dos dados*/

DECLARE

  CURSOR C_MARCA IS 
    SELECT  EMPRESA,
            MARCA,
            EMPREENDIMENTO,
            CLIENTE,
            REGIONAL,
            OBRA, 
	        BLOCO, 
	        UNIDADE, 
	        DT_VENDA, 
	        DT_CHAVES, 
	        CARTEIRA, 
	        SALDO_DEVEDOR, 
	        DT_BASE, 
	        TOTAL_ATRASO, 
	        FAIXA_ATRASO, 
	        DIAS_ATRASO, 
	        VALOR_PAGO_ATUALIZADO, 
	        VALOR_PAGO, 
	        STATUS, 
	        DT_RENEGOCIACAO, 
        	DESCONTO, 
	        VAGA, 
	        VGV
        FROM   T_MARCA;

    v_stage1_MARCA C_MARCA%ROWTYPE;

    BEGIN
        OPEN C_MARCA;
    
            LOOP
				FETCH C_MARCA INTO v_stage1_MARCA;

            	EXIT WHEN C_MARCA%NOTFOUND;            

            	INSERT INTO ST1_MARCA
                    (EMPRESA,
                    MARCA,
                    EMPREENDIMENTO,
                    CLIENTE,
                    REGIONAL,
                    OBRA,
                    BLOCO,
                    UNIDADE,
                    DT_VENDA,
                    DT_CHAVES,
                    CARTEIRA,
                    SALDO_DEVEDOR,
                    DT_BASE,
                    VALOR_PAGO_ATUALIZADO,
                    VALOR_PAGO,
                    STATUS,
                    DT_RENEGOCIACAO,
                    DESCONTO,
                    VAGA,
                    VGV)
                VALUES
                    (v_stage1_MARCA.EMPRESA,
                    v_stage1_MARCA.MARCA,
                    v_stage1_MARCA.EMPREENDIMENTO,
                    v_stage1_MARCA.CLIENTE,
                    v_stage1_MARCA.REGIONAL,
                    v_stage1_MARCA.OBRA,
                    v_stage1_MARCA.BLOCO,
                    v_stage1_MARCA.UNIDADE,
                    v_stage1_MARCA.DT_VENDA,
                    v_stage1_MARCA.DT_CHAVES,
                    v_stage1_MARCA.CARTEIRA,
                    v_stage1_MARCA.SALDO_DEVEDOR,
                    v_stage1_MARCA.DT_BASE,
                    v_stage1_MARCA.VALOR_PAGO_ATUALIZADO,
                    v_stage1_MARCA.VALOR_PAGO,
                    v_stage1_MARCA.STATUS,
                    v_stage1_MARCA.DT_RENEGOCIACAO,
                    v_stage1_MARCA.DESCONTO,
                    v_stage1_MARCA.VAGA,
                    v_stage1_MARCA.VGV);
      
            END LOOP;
            COMMIT;
           
        CLOSE C_MARCA;
    END;
        
SELECT * FROM ST1_MARCA;        
/* Stage 2 MARCA - Registrando os dados limpos. */
CREATE TABLE ST2_MARCA
    EMPRESA INTEGER NOT NULL, 
	MARCA VARCHAR2(6) NOT NULL, 
	EMPREENDIMENTO VARCHAR2(31) NOT NULL, 
	CLIENTE VARCHAR2(12) NOT NULL, 
	REGIONAL VARCHAR2(9) NOT NULL, 
	OBRA NUMBER(*,0) NOT NULL,  
	BLOCO NUMBER(*,0) NOT NULL, 
	UNIDADE NUMBER(*,0) NOT NULL, 
	DT_VENDA DATE NOT NULL, 
	DT_CHAVES DATE NOT NULL, 
	CARTEIRA NUMBER NOT NULL, 
	SALDO_DEVEDOR NUMBER NOT NULL, 
	DT_BASE DATE NOT NULL, 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2) NOT NULL, 
	VALOR_PAGO NUMBER(12,2) NOT NULL, 
	STATUS VARCHAR2(1) NOT NULL, 
	DT_RENEGOCIACAO VARCHAR2(1) NOT NULL, 
	DESCONTO VARCHAR2(1) NOT NULL, 
	VAGA VARCHAR2(1) NOT NULL, 
	VGV NUMBER NOT NULL
);

/*Registrando os dados consistentes*/

DECLARE
    CURSOR C_Q_MARCA IS 
        SELECT * FROM ST1_MARCA;
	
V_Q_MARCA C_Q_MARCA%ROWTYPE;

BEGIN
	OPEN C_Q_MARCA;

		LOOP	
			FETCH C_Q_MARCA INTO V_Q_MARCA;
			EXIT WHEN C_Q_MARCA%NOTFOUND;

			IF(V_Q_MARCA.EMPRESA IS NOT NULL) AND
			  (V_Q_MARCA.MARCA IS NOT NULL) AND
		      (V_Q_MARCA.EMPREENDIMENTO IS NOT NULL) AND
		      (V_Q_MARCA.CLIENTE IS NOT NULL) AND
		      (V_Q_MARCA.REGIONAL IS NOT NULL) AND
		      (V_Q_MARCA.OBRA IS NOT NULL) AND
		      (V_Q_MARCA.BLOCO IS NOT NULL) AND
		      (V_Q_MARCA.UNIDADE IS NOT NULL) AND
		      (V_Q_MARCA.DT_VENDA IS NOT NULL) AND
		      (V_Q_MARCA.DT_CHAVES IS NOT NULL) AND
		      (V_Q_MARCA.CARTEIRA IS NOT NULL) AND
		      (V_Q_MARCA.SALDO_DEVEDOR IS NOT NULL) AND
		      (V_Q_MARCA.DT_BASE IS NOT NULL) AND
		      (V_Q_MARCA.VALOR_PAGO_ATUALIZADO IS NOT NULL) AND
		      (V_Q_MARCA.VALOR_PAGO IS NOT NULL) AND
		      (V_Q_MARCA.STATUS IS NOT NULL) AND
		      (V_Q_MARCA.DT_RENEGOCIACAO IS NOT NULL) AND
		      (V_Q_MARCA.DESCONTO IS NOT NULL) AND
		      (V_Q_MARCA.VAGA IS NOT NULL) AND
		      (V_Q_MARCA.VGV IS NOT NULL) THEN
              
			    INSERT INTO ST2_MARCA
                  VALUES 
                    (V_Q_MARCA.EMPRESA,
                     V_Q_MARCA.MARCA,
                     V_Q_MARCA.EMPREENDIMENTO,
                     V_Q_MARCA.CLIENTE,
                     V_Q_MARCA.REGIONAL,
                     V_Q_MARCA.OBRA,
                     V_Q_MARCA.BLOCO,
                     V_Q_MARCA.UNIDADE,
                     V_Q_MARCA.DT_VENDA,
                     V_Q_MARCA.DT_CHAVES,
                     V_Q_MARCA.CARTEIRA,
                     V_Q_MARCA.SALDO_DEVEDOR,
                     V_Q_MARCA.DT_BASE,
                     V_Q_MARCA.VALOR_PAGO_ATUALIZADO,
                     V_Q_MARCA.VALOR_PAGO,
                     V_Q_MARCA.STATUS,
                     V_Q_MARCA.DT_RENEGOCIACAO,
                     V_Q_MARCA.DESCONTO,
                     V_Q_MARCA.VAGA,
                     V_Q_MARCA.VGV);
			END IF;
		END LOOP;
		COMMIT;
	CLOSE C_Q_MARCA;
END;


-- Stage3 MARCA
-- Criacao da tabela de metadado
-- Tabela auxiliar para criar a dimensão

CREATE TABLE METADADO_MARCA
(KEY_MARCA INTEGER,
PK_MARCA   INTEGER);


CREATE TABLE ST3_MARCA
(
    SK_MARCA INTEGER NOT NULL,
    EMPRESA INTEGER NOT NULL, 
	MARCA VARCHAR2(6) NOT NULL, 
	EMPREENDIMENTO VARCHAR2(31) NOT NULL, 
	CLIENTE VARCHAR2(12) NOT NULL, 
	REGIONAL VARCHAR2(9) NOT NULL, 
	OBRA NUMBER(*,0) NOT NULL,  
	BLOCO NUMBER(*,0) NOT NULL, 
	UNIDADE NUMBER(*,0) NOT NULL, 
	DT_VENDA DATE NOT NULL, 
	DT_CHAVES DATE NOT NULL, 
	CARTEIRA NUMBER NOT NULL, 
	SALDO_DEVEDOR NUMBER NOT NULL, 
	DT_BASE DATE NOT NULL, 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2) NOT NULL, 
	VALOR_PAGO NUMBER(12,2) NOT NULL, 
	STATUS VARCHAR2(1) NOT NULL, 
	DT_RENEGOCIACAO VARCHAR2(1) NOT NULL, 
	DESCONTO VARCHAR2(1) NOT NULL, 
	VAGA VARCHAR2(1) NOT NULL, 
	VGV NUMBER NOT NULL
);

DECLARE
	CURSOR C_MARCA IS
		SELECT * FROM ST2_MARCA;

V_ST3_MARCA  C_MARCA%ROWTYPE;
V_PK NUMBER;
V_SK NUMBER;

BEGIN 
	OPEN C_MARCA;
		LOOP
			FETCH C_MARCA INTO V_ST3_MARCA;
			EXIT WHEN C_MARCA%NOTFOUND;

            SELECT COUNT(KEY_MARCA)
            INTO V_PK
            FROM METADADO_MARCA
            WHERE V_ST3_MARCA.CARTEIRA = PK_MARCA;

			IF V_PK = 0 THEN
                SELECT NVL(MAX(KEY_MARCA),0)
				INTO V_SK
				FROM METADADO_MARCA;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_MARCA
				VALUES
				(V_SK,
				V_ST3_MARCA.ID);

                INSERT INTO ST3_MARCA
                VALUES 
                    (V_SK,
                     V_ST3_MARCA.EMPRESA,
                     V_ST3_MARCA.MARCA,
                     V_ST3_MARCA.EMPREENDIMENTO,
                     V_ST3_MARCA.CLIENTE,
                     V_ST3_MARCA.REGIONAL,
                     V_ST3_MARCA.OBRA,
                     V_ST3_MARCA.BLOCO,
                     V_ST3_MARCA.UNIDADE,
                     V_ST3_MARCA.DT_VENDA,
                     V_ST3_MARCA.DT_CHAVES,
                     V_ST3_MARCA.CARTEIRA,
                     V_ST3_MARCA.SALDO_DEVEDOR,
                     V_ST3_MARCA.DT_BASE,
                     V_ST3_MARCA.VALOR_PAGO_ATUALIZADO,
                     V_ST3_MARCA.VALOR_PAGO,
                     V_ST3_MARCA.STATUS,
                     V_ST3_MARCA.DT_RENEGOCIACAO,
                     V_ST3_MARCA.DESCONTO,
                     V_ST3_MARCA.VAGA,
                     V_ST3_MARCA.VGV);
			END IF;
		END LOOP;
		COMMIT;
	CLOSE C_MARCA;
END;

SELECT * FROM ST3_MARCA;
SELECT * FROM METADADO_MARCA;

/* STAGE 4 */
/* Criacao da tabela de dimensao MARCA */

CREATE TABLE DIM_MARCA
(
    SK_MARCA INTEGER NOT NULL,
    EMPRESA INTEGER NOT NULL, 
	MARCA VARCHAR2(6) NOT NULL, 
	EMPREENDIMENTO VARCHAR2(31) NOT NULL, 
	CLIENTE VARCHAR2(12) NOT NULL, 
	REGIONAL VARCHAR2(9) NOT NULL, 
	OBRA NUMBER(*,0) NOT NULL,  
	BLOCO NUMBER(*,0) NOT NULL, 
	UNIDADE NUMBER(*,0) NOT NULL, 
	DT_VENDA DATE NOT NULL, 
	DT_CHAVES DATE NOT NULL, 
	CARTEIRA NUMBER NOT NULL, 
	SALDO_DEVEDOR NUMBER NOT NULL, 
	DT_BASE DATE NOT NULL, 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2) NOT NULL, 
	VALOR_PAGO NUMBER(12,2) NOT NULL, 
	STATUS VARCHAR2(1) NOT NULL, 
	DT_RENEGOCIACAO VARCHAR2(1) NOT NULL, 
	DESCONTO VARCHAR2(1) NOT NULL, 
	VAGA VARCHAR2(1) NOT NULL, 
	VGV NUMBER NOT NULL
);

DECLARE
	CURSOR C_MARCA IS
		SELECT * FROM ST3_MARCA;

V_ST4_MARCA C_MARCA%ROWTYPE;


BEGIN 
	OPEN C_MARCA;
		LOOP
			FETCH C_MARCA INTO V_ST4_MARCA;
			EXIT WHEN C_MARCA%NOTFOUND;

			INSERT INTO DIM_MARCA
			VALUES
            (
                V_ST4_MARCA.EMPRESA,
                V_ST4_MARCA.MARCA,
                V_ST4_MARCA.EMPREENDIMENTO,
                V_ST4_MARCA.CLIENTE,
                V_ST4_MARCA.REGIONAL,
                V_ST4_MARCA.OBRA,
                V_ST4_MARCA.BLOCO,
                V_ST4_MARCA.UNIDADE,
                V_ST4_MARCA.DT_VENDA,
                V_ST4_MARCA.DT_CHAVES,
                V_ST4_MARCA.CARTEIRA,
                V_ST4_MARCA.SALDO_DEVEDOR,
                V_ST4_MARCA.DT_BASE,
                V_ST4_MARCA.VALOR_PAGO_ATUALIZADO,
                V_ST4_MARCA.VALOR_PAGO,
                V_ST4_MARCA.STATUS,
                V_ST4_MARCA.DT_RENEGOCIACAO,
                V_ST4_MARCA.DESCONTO,
                V_ST4_MARCA.VAGA,
                V_ST4_MARCA.VGV
            );
		END LOOP;
		COMMIT;
	CLOSE C_MARCA;
END;