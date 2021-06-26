DROP TABLE ST1_MARCA;
DROP TABLE ST2_MARCA;
DROP TABLE ST3_MARCA;
DROP TABLE DIM_MARCA;
DROP TABLE METADADO_MARCA;

-- Satge 1 MARCA
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
	TOTAL_ATRASO NUMBER(*,0), 
	FAIXA_ATRASO NUMBER(*,0), 
	DIAS_ATRASO NUMBER(*,0), 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2), 
	VALOR_PAGO NUMBER(12,2), 
	STATUS VARCHAR2(1), 
	DT_RENEGOCIACAO VARCHAR2(1), 
	DESCONTO VARCHAR2(1), 
	VAGA VARCHAR2(1), 
	VGV NUMBER
)
;

/*Passo de coleta dos dados*/

DECLARE

  CURSOR C_MARCA
 IS 
    SELECT  Id,
            EMPRESA,
            EMPREENDIMENTO,
            CLIENTE,
            REGIONAL,
            OBRA, 
	        BLOCO NUMBER(*,0), 
	        UNIDADE NUMBER(*,0), 
	        DT_VENDA DATE, 
	        DT_CHAVES DATE, 
	        CARTEIRA NUMBER, 
	        SALDO_DEVEDOR NUMBER, 
	        DT_BASE DATE, 
	        TOTAL_ATRASO NUMBER(*,0), 
	        FAIXA_ATRASO NUMBER(*,0), 
	        DIAS_ATRASO NUMBER(*,0), 
	        VALOR_PAGO_ATUALIZADO NUMBER(12,2), 
	        VALOR_PAGO NUMBER(12,2), 
	        STATUS   VARCHAR2(1), 
	        DT_RENEGOCIACAO VARCHAR2(1), 
        	DESCONTO VARCHAR2(1), 
	        VAGA VARCHAR2(1), 
	        VGV  NUMBER
        FROM   Coobrigado;

    v_stage1_MARCA C_MARCA%ROWTYPE;

    BEGIN
         OPEN C_MARCA
        ;

    
            LOOP

               FETCH C_MARCA
             INTO v_stage1_MARCA
            ;

               EXIT WHEN C_MARCA
            %NOTFOUND;            

               INSERT INTO ST1_MARCA

               (Id,
                Obra,
                Bloco,
                Unidade,
                Nome,
                DocumentoMARCA
            ,
                PercentualParticipacao,
                Ativo)
                VALUES
               (v_stage1_MARCA
            .Id,
                v_stage1_MARCA
            .Obra,
                v_stage1_MARCA
            .Bloco,
                v_stage1_MARCA
            .Unidade,
                v_stage1_MARCA
            .Nome,
                v_stage1_MARCA
            .CPF_CNPJ,
                v_stage1_MARCA
            .PercentualParticipacao,
                v_stage1_MARCA
            .Ativo
	           );

      
             END LOOP;
             COMMIT;
           CLOSE C_MARCA;
        END;
        
SELECT * FROM ST1_MARCA;        

-- Stage 2 MARCA - Registrando os dados limpos.
CREATE TABLE ST2_MARCA
CST3_MARCA
IdDIM_MARCA			           integer NOT NULL,
ObraCMETADADO_MARCA        char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
DocumentoMARCA 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NULL
)
;


/*Registrando os dados consistentes*/

DECLARE
	
    CURSOR C_Q_MARCA
 IS 
        SELECT * FROM ST1_MARCA;
	
V_Q_MARCA C_Q_MARCA%ROWTYPE;

BEGIN
	OPEN C_Q_MARCA
;
		LOOP	
			FETCH C_Q_MARCA
         INTO V_Q_MARCA
        ;
			EXIT WHEN C_Q_MARCA
        %NOTFOUND;

			IF(V_Q_MARCA
        .Id IS NOT NULL) AND
              (V_Q_MARCA
            .Obra IS NOT NULL) AND
              (V_Q_MARCA
            .Bloco IS NOT NULL) AND
			  (V_Q_MARCA
            .Unidade IS NOT NULL) AND
			  (V_Q_MARCA
            .Nome IS NOT NULL) AND
			  (V_Q_MARCA
            .DocumentoMARCA
             IS NOT NULL) AND
			  (V_Q_MARCA
            .PercentualParticipacao IS NOT NULL) AND
			  (V_Q_MARCA
            .Ativo IS NOT NULL) THEN

				INSERT INTO ST2_MARCA
				CST3_MARCA
                (V_Q_DIM_MARCA.Id,
                 V_Q_MARCA
                .Obra,CMETADADO_MARCA                 V_Q_MARCA
                .Bloco,
                 V_Q_MARCA
                .Unidade,
                 V_Q_MARCA
                .Nome,
                 V_Q_MARCA
                .DocumentoMARCA
                ,
                 V_Q_MARCA
                .PercentualParticipacao,
                 V_Q_MARCA
                .Ativo);

			END IF;
		END LOOP;
		
		COMMIT;

	CLOSE C_Q_MARCA
;
END;


-- Stage3 MARCA
-- Criacao da tabela de metadado
-- Tabela auxiliar para criar a dimensão

CREATE TABLE METADADO_MARCA
(KEY_MARCA INTEGER,
PK_MARCA   INTEGER);


CREATE TABLE ST3_MARCA
DIM_MARCA
SK_MARCACMETADADO_MARCA                  integer NOT NULL,
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
	TOTAL_ATRASO NUMBER(*,0), 
	FAIXA_ATRASO NUMBER(*,0), 
	DIAS_ATRASO NUMBER(*,0), 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2), 
	VALOR_PAGO NUMBER(12,2), 
	STATUS VARCHAR2(1), 
	DT_RENEGOCIACAO VARCHAR2(1), 
	DESCONTO VARCHAR2(1), 
	VAGA VARCHAR2(1), 
	VGV NUMBER
)
;


DECLARE
	CURSOR C_MARCA
 IS
		SELECT * FROM ST2_MARCA;
CST3_MARCADIM_MARCA
V_ST3_MARCA  C_MARCA%CMETADADO_MARCA;
V_PK DIM_MARCA;
V_SK NUMBER;


CMETADADO_MARCA
	OPEN C_MARCA
;
		LOOP
			FETCH C_MARCA
         INTO V_ST3_MARCA;
			EXIT WHEN C_MARCA
        %NOTFOUNDDIM_MARCA

			CMETADADO_MARCA COUNT(KEY_MARCA
        )
			INTO V_PK
			FROM METADADO_MARCA
            WHERE V_ST3_MARCA.ID = PK_MARCA
        ;DIM_MARCA
			IF V_PK = 0 THEN
CMETADADO_MARCA NVL(MAX(KEY_MARCA),0)
				INTO V_SK
				FROM METADADO_MARCA;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_MARCA
				VALUES
				(V_SK,
				V_ST3_MARCA.ID);DIM_MARCA

CMETADADO_MARCA INTO ST3_MARCA
				DIM_MARCA
			        (V_SK,
CMETADADO_MARCA                 V_ST3_MARCA.Id,
			        V_ST3_DIM_MARCA.Obra,
			        V_ST3_DIM_MARCA.CMETADADO_MARCAEo,
			        V_ST3_DIM_MARCA.CMETADADO_MARCAEade,
			        V_ST3_DIM_MARCA.CMETADADO_MARCA,
                    V_ST3_DIM_MARCA.CMETADADO_MARCAEmentoMARCA
                ,
                    V_ST3_DIM_MARCA.CMETADADO_MARCAEentualParticipacao,
                    V_ST3_DIM_MARCA.CMETADADO_MARCAEo);DIM_MARCA
			END IF;

		CMETADADO_MARCA LOOP;

		COMMIT;
	
	CLOSE C_MARCA
;

END;

SELECT * FROM ST3_MARCA;DIM_MARCA
SELECT * FROM METADADO_MARCA


CMETADADO_MARCA 4 

--Criacao da tabela de dimensao MARCA

CREATE TABLE DIM_MARCA
(
SK_CMETADADO_MARCA                     integer NOT NULL,
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
	TOTAL_ATRASO NUMBER(*,0), 
	FAIXA_ATRASO NUMBER(*,0), 
	DIAS_ATRASO NUMBER(*,0), 
	VALOR_PAGO_ATUALIZADO NUMBER(12,2), 
	VALOR_PAGO NUMBER(12,2), 
	STATUS VARCHAR2(1), 
	DT_RENEGOCIACAO VARCHAR2(1), 
	DESCONTO VARCHAR2(1), 
	VAGA VARCHAR2(1), 
	VGV NUMBER
);

DECLARE
	CURSOR C_MARCA
 IS
		SELECT * FROM ST3_MARCA;DIM_MARCA
V_ST4_MARCA C_MARCA%ROWTYPE;


CMETADADO_MARCA
	OPEN C_MARCA
;
		LOOP
			FETCH C_MARCA
         INTO V_ST4_MARCA
        ;
			EXIT WHEN C_MARCA
        %NOTFOUND;


			INSERT INTO DIM_MARCA
			VALUES
			CMETADADO_MARCA_ST4_MARCA
        .SK_MARCA
        ,
             V_ST4_MARCA
            .Id,
			 V_ST4_MARCA
            .Obra,
			 V_ST4_MARCA
            .Bloco,
			 V_ST4_MARCA
            .Unidade,
			 V_ST4_MARCA
            .Nome,
             V_ST4_MARCA
            .DocumentoMARCA
            ,
             V_ST4_MARCA
            .PercentualParticipacao,
             V_ST4_MARCA
            .Ativo);

		END LOOP;

		COMMIT;
	CLOSE C_MARCA
;

END;