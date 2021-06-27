/* DROP TABLES */
DROP TABLE ST1_EMP;
DROP TABLE ST2_EMP;
DROP TABLE ST3_EMP;
DROP TABLE DIM_EMP;
DROP TABLE METADADO_EMP;

/* STAGE 1 EMP */ 
/*Extração dos dados*/

CREATE TABLE ST1_EMP
(
    obra                              NUMBER(4) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6),
    valorvenda                        NUMBER(15, 2),
    dataliberacaochaves               TIMESTAMP(6),
    formapagamento                    INTEGER,
    datahabitese                      TIMESTAMP(6),
    datachaves                        TIMESTAMP(6),
    indiceprechaves                   VARCHAR2(10),
    indiceposchaves                   VARCHAR2(10),
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6),
    valorpago                         NUMBER(13, 2)
);

/*Passo de coleta dos dados*/

DECLARE
  CURSOR C_EMP IS 
    SELECT  obra,
            empresa,
            situacaounidade,
            datavenda,
            valorvenda,
            dataliberacaochaves,
            formapagamento,
            datahabitese,
            datachaves,
            indiceprechaves,
            indiceposchaves,
            saldodevedor,
            dataprevisaoentrega,
            valorpago  
    FROM  posicaofinanceira;

    v_stage1_emp C_EMP%ROWTYPE;


    BEGIN
        OPEN C_EMP;
    
            LOOP

                FETCH C_EMP INTO v_stage1_emp;
                EXIT WHEN C_EMP%NOTFOUND;            

                INSERT INTO ST1_EMP
                (
                   obra,
                   empresa,
                   situacaounidade,
                   datavenda,
                   valorvenda,
                   dataliberacaochaves,
                   formapagamento,
                   datahabitese,
                   datachaves,
                   indiceprechaves,
                   indiceposchaves,
                   saldodevedor,
                   dataprevisaoentrega,
                   valorpago
                ) 
                VALUES 
                (
                   v_stage1_emp.obra,
                   v_stage1_emp.empresa,
                   v_stage1_emp.situacaounidade,
                   v_stage1_emp.datavenda,
                   v_stage1_emp.valorvenda,
                   v_stage1_emp.dataliberacaochaves,
                   v_stage1_emp.formapagamento,
                   v_stage1_emp.datahabitese,
                   v_stage1_emp.datachaves,
                   v_stage1_emp.indiceprechaves,
                   v_stage1_emp.indiceposchaves,
                   v_stage1_emp.saldodevedor,
                   v_stage1_emp.dataprevisaoentrega,
                   v_stage1_emp.valorpago
                );
            END LOOP;
            COMMIT;
        CLOSE C_EMP;
    END;
        
SELECT * FROM ST1_EMP;        

/* Stage 2 emp - Registrando os dados limpos. */

CREATE TABLE ST2_EMP
(
    obra                              NUMBER(4) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6),
    valorvenda                        NUMBER(15, 2),
    dataliberacaochaves               TIMESTAMP(6),
    formapagamento                    INTEGER,
    datahabitese                      TIMESTAMP(6),
    datachaves                        TIMESTAMP(6),
    indiceprechaves                   VARCHAR2(10),
    indiceposchaves                   VARCHAR2(10),
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6),
    valorpago                         NUMBER(13, 2)
);

/*Registrando os dados consistentes*/

DECLARE	
    CURSOR C_Q_EMP IS 
        SELECT * FROM ST1_EMP;
	
V_Q_EMP C_Q_EMP%ROWTYPE;

BEGIN
	OPEN C_Q_EMP;
		LOOP
			FETCH C_Q_EMP INTO V_Q_EMP;
			EXIT WHEN C_Q_emp%NOTFOUND;

			IF(V_Q_EMP.obra IS NOT NULL) AND
              (V_Q_EMP.empresa IS NOT NULL) AND
              (V_Q_EMP.situacaounidade IS NOT NULL) AND
              (V_Q_EMP.datavenda IS NOT NULL) AND
              (V_Q_EMP.valorvenda IS NOT NULL) AND
              (V_Q_EMP.dataliberacaochaves IS NOT NULL) AND
              (V_Q_EMP.formapagamento IS NOT NULL) AND
              (V_Q_EMP.datahabitese IS NOT NULL) AND
              (V_Q_EMP.datachaves IS NOT NULL) AND
              (V_Q_EMP.indiceprechaves IS NOT NULL) AND
              (V_Q_EMP.indiceposchaves IS NOT NULL) AND
              (V_Q_EMP.saldodevedor IS NOT NULL) AND
              (V_Q_EMP.dataprevisaoentrega IS NOT NULL) AND
              (V_Q_EMP.valorpago IS NOT NULL) THEN

				INSERT INTO ST2_EMP
				VALUES 
                (
                    V_Q_EMP.obra,
                    V_Q_EMP.empresa,
                    V_Q_EMP.situacaounidade,
                    V_Q_EMP.datavenda,
                    V_Q_EMP.valorvenda,
                    V_Q_EMP.dataliberacaochaves,
                    V_Q_EMP.formapagamento,
                    V_Q_EMP.datahabitese,
                    V_Q_EMP.datachaves,
                    V_Q_EMP.indiceprechaves,
                    V_Q_EMP.indiceposchaves,
                    V_Q_EMP.saldodevedor,
                    V_Q_EMP.dataprevisaoentrega,
                    V_Q_EMP.valorpago
                )
			END IF;
		END LOOP;
		COMMIT;
	CLOSE C_Q_emp;
END;

/* STAGE E */
/* Transformação dos dados */

CREATE TABLE METADADO_EMP
(KEY_EMP INTEGER,
PK_EMP   INTEGER);


CREATE TABLE ST3_EMP
(
    SK_EMP                            INTEGER NOT NULL,
    obra                              NUMBER(4) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6) NOT NULL,
    valorvenda                        NUMBER(15, 2) NOT NULL,
    dataliberacaochaves               TIMESTAMP(6) NOT NULL,
    formapagamento                    INTEGER NOT NULL,
    datahabitese                      TIMESTAMP(6) NOT NULL,
    datachaves                        TIMESTAMP(6) NOT NULL,
    indiceprechaves                   VARCHAR2(10) NOT NULL,
    indiceposchaves                   VARCHAR2(10) NOT NULL,
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6) NOT NULL,
    valorpago                         NUMBER(13, 2) NOT NULL,
);


DECLARE
	CURSOR C_EMP IS
		SELECT * FROM ST2_EMP;

V_ST3_EMP  C_EMP%ROWTYPE;
V_PK NUMBER;
V_SK NUMBER;

BEGIN
	OPEN C_EMP;
		LOOP
			FETCH C_EMP INTO V_ST3_EMP;
			EXIT WHEN C_EMP%NOTFOUND;

			SELECT COUNT(KEY_EMP)
			INTO V_PK
			FROM METADADO_EMP
            WHERE V_ST3_EMP.obra = PK_EMP;

			IF V_PK = 0 THEN
                SELECT NVL(MAX(KEY_EMP),0)
				INTO V_SK
				FROM METADADO_EMP;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_EMP
				VALUES
				(V_SK,
				V_ST3_EMP.obra);


				INSERT INTO ST3_EMP
				VALUES
			        (V_SK,
                    V_ST3_EMP.obra,
			        V_ST3_EMP.empresa,
			        V_ST3_EMP.situacaounidade,
			        V_ST3_EMP.datavenda,
			        V_ST3_EMP.valorvenda,
                    V_ST3_EMP.dataliberacaochaves,                ,
                    V_ST3_EMP.formapagamento,                ,
                    V_ST3_EMP.datahabitese,                ,
                    V_ST3_EMP.datachaves,                ,
                    V_ST3_EMP.indiceprechaves,
                    V_ST3_EMP.indiceposchaves,
                    V_ST3_EMP.saldodevedor,
                    V_ST3_EMP.dataprevisaoentrega,
                    V_ST3_EMP.valorpago);
    		END IF;
    	END LOOP;
	    COMMIT;
	CLOSE C_emp;
END;

SELECT * FROM ST3_EMP;
SELECT * FROM METADADO_EMP

/* STAGE 4 */
/* Criacao da tabela de dimensao emp */

CREATE TABLE DIM_EMP
(
    SK_emp                            integer NOT NULL,
    obra                              NUMBER(4) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6) NOT NULL,
    valorvenda                        NUMBER(15, 2) NOT NULL,
    dataliberacaochaves               TIMESTAMP(6) NOT NULL,
    formapagamento                    INTEGER NOT NULL,
    datahabitese                      TIMESTAMP(6) NOT NULL,
    datachaves                        TIMESTAMP(6) NOT NULL,
    indiceprechaves                   VARCHAR2(10) NOT NULL,
    indiceposchaves                   VARCHAR2(10) NOT NULL,
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6) NOT NULL
    valorpago                         NUMBER(13, 2) NOT NULL,
);

DECLARE
	CURSOR C_EMP IS
		SELECT * FROM ST3_EMP;

V_ST4_emp C_EMP%ROWTYPE;


BEGIN
	OPEN C_emp;
		LOOP
			FETCH C_EMP INTO V_ST4_EMP;
			EXIT WHEN C_emp%NOTFOUND;

			INSERT INTO DIM_EMP
			VALUES
            (
                V_ST4_EMP.obra,
                V_ST4_EMP.empresa,
                V_ST4_EMP.situacaounidade,
                V_ST4_EMP.datavenda,
                V_ST4_EMP.valorvenda,
                V_ST4_EMP.dataliberacaochaves,
                V_ST4_EMP.formapagamento,
                V_ST4_EMP.datahabitese,
                V_ST4_EMP.datachaves,
                V_ST4_EMP.indiceprechaves,
                V_ST4_EMP.indiceposchaves,
                V_ST4_EMP.saldodevedor,
                V_ST4_EMP.dataprevisaoentrega,
                V_ST4_EMP.valorpago,
            );
		END LOOP;
		COMMIT;
	CLOSE C_EMP;
END;