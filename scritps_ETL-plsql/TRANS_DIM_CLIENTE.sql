/*TRANSFORMAÇÃO TABELA COOBRIGADO > DIM_CLIENTE*/
/*DROP TABLES*/
DROP TABLE ST1_cliente;
DROP TABLE ST2_cliente;
DROP TABLE ST3_cliente;
DROP TABLE METADADO_CLIENTE;
DROP TABLE DIM_CLIENTE;

-- Satge 1 Cliente
/*Extração dos dados*/

CREATE TABLE ST1_cliente
(
Id      			           integer,
Obra    			           char(4),
Bloco   			           char(2),
Unidade 			           char(6),
Nome 				           varchar2(150),
DocumentoCliente 			   varchar2(20),
PercentualParticipacao         number(5, 2),
Ativo 				           number
)
;

/*Passo de coleta dos dados*/

DECLARE CURSOR C_Cliente IS 
      SELECT Id,
             obra,
             bloco,
             unidade,
             nome,
             CPF_CNPJ,
             PercentualParticipacao,
             Ativo
      FROM   Coobrigado;

      v_stage1_cliente C_Cliente%ROWTYPE;

       BEGIN
           OPEN C_Cliente;
            
            LOOP
               FETCH C_Cliente INTO v_stage1_cliente;

               EXIT WHEN C_Cliente%NOTFOUND;            

               INSERT INTO ST1_Cliente

               (Id,
                Obra,
                Bloco,
                Unidade,
                Nome,
                DocumentoCliente,
                PercentualParticipacao,
                Ativo)
                VALUES
               (v_stage1_cliente.Id,
                v_stage1_cliente.Obra,
                v_stage1_cliente.Bloco,
                v_stage1_cliente.Unidade,
                v_stage1_cliente.Nome,
                v_stage1_cliente.CPF_CNPJ,
                v_stage1_cliente.PercentualParticipacao,
                v_stage1_cliente.Ativo
	           );

             END LOOP;
             COMMIT;

           CLOSE C_Cliente;
        END;
        
SELECT * FROM ST1_cliente;        


-- Stage 2 
/*Passo de limpeza dos dados*/

CREATE TABLE ST2_cliente
(
Id      			           integer NOT NULL,
Obra    			           char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
DocumentoCliente 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NOT NULL
)
;

/*Registrando os dados consistentes*/

DECLARE
	
    CURSOR C_Q_CLIENTE IS 
        SELECT * FROM ST1_cliente;
	
V_Q_CLIENTE C_Q_CLIENTE%ROWTYPE;

BEGIN
	OPEN C_Q_CLIENTE;
		LOOP	
			FETCH C_Q_CLIENTE INTO V_Q_CLIENTE;
			EXIT WHEN C_Q_CLIENTE%NOTFOUND;

			IF(V_Q_CLIENTE.Id IS NOT NULL) AND
              (V_Q_CLIENTE.Obra IS NOT NULL) AND
              (V_Q_CLIENTE.Bloco IS NOT NULL) AND
			  (V_Q_CLIENTE.Unidade IS NOT NULL) AND
			  (V_Q_CLIENTE.Nome IS NOT NULL) AND
			  (V_Q_CLIENTE.DocumentoCliente IS NOT NULL) AND
			  (V_Q_CLIENTE.PercentualParticipacao IS NOT NULL) AND
			  (V_Q_CLIENTE.Ativo IS NOT NULL) THEN

				INSERT INTO ST2_cliente
				VALUES
                (V_Q_CLIENTE.Id,
                 V_Q_CLIENTE.Obra,
                 V_Q_CLIENTE.Bloco,
                 V_Q_CLIENTE.Unidade,
                 V_Q_CLIENTE.Nome,
                 V_Q_CLIENTE.DocumentoCliente,
                 V_Q_CLIENTE.PercentualParticipacao,
                 V_Q_CLIENTE.Ativo);

			END IF;
		END LOOP;
		
		COMMIT;

	CLOSE C_Q_CLIENTE;
END;


-- Stage3 Cliente
-- Transformação dos dados
-- Nessa etapa, realizamos as devidas transformações caso necessário e a inclusão da surrogate key.

CREATE TABLE METADADO_CLIENTE
(KEY_Cliente INTEGER,
PK_Cliente   INTEGER);


CREATE TABLE ST3_cliente
(
SK_CLIENTE                     integer NOT NULL,
Id      			           integer NOT NULL,
Obra    			           char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
DocumentoCliente 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NULL
)
;


DECLARE
	CURSOR C_CLIENTE IS
		SELECT * FROM ST2_cliente;
    

V_ST3_CLIENTE  C_CLIENTE%ROWTYPE;
V_PK NUMBER;
V_SK NUMBER;


BEGIN
	OPEN C_CLIENTE;
		LOOP
			FETCH C_CLIENTE INTO V_ST3_CLIENTE;
			EXIT WHEN C_CLIENTE%NOTFOUND;

			SELECT COUNT(KEY_Cliente)
			INTO V_PK
			FROM METADADO_CLIENTE
            WHERE V_ST3_CLIENTE.ID = PK_Cliente;

			IF V_PK = 0 THEN
				SELECT NVL(MAX(KEY_Cliente),0)
				INTO V_SK
				FROM METADADO_CLIENTE;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_CLIENTE
				VALUES
				(V_SK,
				V_ST3_CLIENTE.ID);


				INSERT INTO ST3_cliente
				VALUES
			        (V_SK,
                    V_ST3_CLIENTE.Id,
			        V_ST3_CLIENTE.Obra,
			        V_ST3_CLIENTE.Bloco,
			        V_ST3_CLIENTE.Unidade,
			        V_ST3_CLIENTE.Nome,
                    V_ST3_CLIENTE.DocumentoCliente,
                    V_ST3_CLIENTE.PercentualParticipacao,
                    V_ST3_CLIENTE.Ativo);

			END IF;

		END LOOP;

		COMMIT;
	
	CLOSE C_CLIENTE;

END;

SELECT * FROM ST3_cliente;

SELECT * FROM METADADO_CLIENTE


--STAGE 4 

--Criacao da tabela de dimensao CLIENTE

CREATE TABLE DIM_CLIENTE
(
SK_CLIENTE                     integer NOT NULL,
Id      			           integer NOT NULL,
Obra    			           char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
DocumentoCliente 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NULL
);

DECLARE
	CURSOR C_CLIENTE IS
		SELECT * FROM ST3_cliente;

V_ST4_CLIENTE C_CLIENTE%ROWTYPE;


BEGIN
	OPEN C_CLIENTE;
		LOOP
			FETCH C_CLIENTE INTO V_ST3_CLIENTE;
			EXIT WHEN C_CLIENTE%NOTFOUND;


			INSERT INTO DIM_CLIENTE
			VALUES
			(V_ST3_CLIENTE.SK_CLIENTE,
             V_ST3_CLIENTE.Id,
			 V_ST3_CLIENTE.Obra,
			 V_ST3_CLIENTE.Bloco,
			 V_ST3_CLIENTE.Unidade,
			 V_ST3_CLIENTE.Nome,
             V_ST3_CLIENTE.DocumentoCliente,
             V_ST3_CLIENTE.PercentualParticipacao,
             V_ST3_CLIENTE.Ativo);

		END LOOP;

		COMMIT;
	CLOSE C_CLIENTE;

END;