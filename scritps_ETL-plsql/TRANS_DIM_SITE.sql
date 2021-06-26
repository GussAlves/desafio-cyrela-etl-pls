/*DROP TABLES*/
DROP TABLE ST1_SITE;
DROP TABLE ST2_SITE;
DROP TABLE ST3_SITE;
DROP TABLE METADADO_SITE;
DROP TABLE DIM_SITE;

-- Satge 1 site
/*Extração dos dados*/

CREATE TABLE ST1_SITE
(
    id                INTEGER NOT NULL,
    documentoSITE  VARCHAR2(18) NOT NULL,
    dataevento        TIMESTAMP(6) NOT NULL,
    tipoevento        INTEGER NOT NULL,
    tipoacesso        INTEGER NOT NULL,
    idatendente       VARCHAR2(40),
    pagina            VARCHAR2(50) NOT NULL,
    atividade         VARCHAR2(255) NOT NULL,
    logerro           VARCHAR2(500),
    origem            VARCHAR2(40)
);

/*Passo de coleta dos dados*/
DECLARE
  CURSOR C_Site IS 
      SELECT Id,
             documentoSITE,
             dataevento,
             tipoevento,
             nome,
             pagina,
             logerro,
             origem
      FROM log_navegacao;


      v_stage1_site C_Site%ROWTYPE;


       BEGIN
           OPEN C_Site;

            LOOP
               FETCH C_Site INTO v_stage1_site;
               EXIT WHEN C_Site%NOTFOUND;            
               INSERT INTO ST1_Site

                    (Id,
                    documentoSITE,
                    dataevento,
                    tipoevento,
                    nome,
                    pagina,
                    logerro,
                    origem)
                VALUES
                (v_stage1_site.Id,
                    v_stage1_site.documentoSITE,
                    v_stage1_site.dataevento,
                    v_stage1_site.tipoevento,
                    v_stage1_site.Nome,
                    v_stage1_site.pagina,
                    v_stage1_site.logerro,
                    v_stage1_site.origem
	           );
             END LOOP;
             COMMIT;
        CLOSE C_SITE;
    END;
        
SELECT * FROM ST1_SITE;        

-- Stage 2 SITE - Registrando os dados limpos.

CREATE TABLE ST2_SITE
(
    id                INTEGER NOT NULL,
    documentoSITE  VARCHAR2(18) NOT NULL,
    dataevento        TIMESTAMP(6) NOT NULL,
    tipoevento        INTEGER NOT NULL,
    tipoacesso        INTEGER NOT NULL,
    idatendente       VARCHAR2(40) NOT NULL,
    pagina            VARCHAR2(50) NOT NULL,
    atividade         VARCHAR2(255) NOT NULL,
    logerro           VARCHAR2(500 NOT NULL),
    origem            VARCHAR2(40) NOT NULL
);

/*Registrando os dados consistentes*/
DECLARE
	
    CURSOR C_Q_SITE IS 
        SELECT * FROM ST1_SITE
    ;
	
V_Q_SITE C_Q_SITE%ROWTYPE;

BEGIN
	OPEN C_Q_SITE;
		LOOP	
			FETCH C_Q_SITE INTO V_Q_SITE;
			EXIT WHEN C_Q_SITE%NOTFOUND;

			IF(V_Q_SITE.Id IS NOT NULL) AND
              (V_Q_SITE.documentoSITE IS NOT NULL) AND
              (V_Q_SITE.dataevento IS NOT NULL) AND
			  (V_Q_SITE.tipoevento IS NOT NULL) AND
			  (V_Q_SITE.idatendente IS NOT NULL) AND
			  (V_Q_SITE.atividade IS NOT NULL) AND
			  (V_Q_SITE.logerro IS NOT NULL) AND
			  (V_Q_SITE.origem IS NOT NULL) THEN

				INSERT INTO ST2_site
				VALUES
                (V_Q_SITE.Id,
                 V_Q_SITE.documentoSITE,
                 V_Q_SITE.dataevento,
                 V_Q_SITE.tipoevento,
                 V_Q_SITE.atividade,
                 V_Q_SITE.logerro,
                 V_Q_SITE.PercentualParticipacao,
                 V_Q_SITE.origem);

			END IF;
		END LOOP;
		
		COMMIT;

	CLOSE C_Q_SITE;
END;


-- Stage3 SITE
-- Transformação dos dados

CREATE TABLE METADADO_SITE
(KEY_SITE INTEGER,
PK_SITE   INTEGER);


CREATE TABLE ST3_SITE
(
    SK_SITE                      integer NOT NULL,
    id                INTEGER NOT NULL,
    documentocliente  VARCHAR2(18) NOT NULL,
    dataevento        TIMESTAMP(6) NOT NULL,
    tipoevento        INTEGER NOT NULL,
    tipoacesso        INTEGER NOT NULL,
    idatendente       VARCHAR2(40),
    pagina            VARCHAR2(50) NOT NULL,
    atividade         VARCHAR2(255) NOT NULL,
    logerro           VARCHAR2(500),
    origem            VARCHAR2(40)
);

DECLARE
	CURSOR C_SITE IS
		SELECT * FROM ST2_site
SITE;
    

V_ST3_SITE  C_SITE%ROWTYPE;
V_PK NUMBER;
V_SK NUMBER;


BEGIN
	OPEN C_SITE;
		LOOP
			FETCH C_SITE INTO V_ST3_SITE;
			EXIT WHEN C_SITE%NOTFOUND;

			SELECT COUNT(KEY_SITE)
			INTO V_PK
			FROM METADADO_SITE
            WHERE V_ST3_SITE.ID = PK_SITE;

			IF V_PK = 0 THEN
				SELECT NVL(MAX(KEY_SITE),0)
				INTO V_SK
				FROM METADADO_SITE;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_SITE
				VALUES
				(V_SK,
				V_ST3_SITE.ID);


				INSERT INTO ST3_SITE
				VALUES
			        (V_SK,
                    V_ST3_SITE.Id,
			        V_ST3_SITE.documentocliente,
			        V_ST3_SITE.dataevento,
			        V_ST3_SITE.tipoevento,
			        V_ST3_SITE.tipoacesso,
                    V_ST3_SITE.idatendente,
                    V_ST3_SITE.pagina,
                    V_ST3_SITE.atividade);

			END IF;

		END LOOP;

		COMMIT;
	
	CLOSE C_SITE;

END;

SELECT * FROM ST3_SITE;

SELECT * FROM METADADO_SITE


--STAGE 4 

--Criacao da tabela de dimensao SITE

CREATE TABLE DIM_SITE
(
    SK_SITE           integer NOT NULL,
    Id      	      integer NOT NULL,
    documentocliente  VARCHAR2(18) NOT NULL,
    dataevento        TIMESTAMP(6) NOT NULL,
    tipoevento        INTEGER NOT NULL,
    tipoacesso        INTEGER NOT NULL,
    idatendente       VARCHAR2(40),
    pagina            VARCHAR2(50) NOT NULL,
    atividade         VARCHAR2(255) NOT NULL,
    logerro           VARCHAR2(500),
    origem            VARCHAR2(40)
);

DECLARE
	CURSOR C_SITE IS
		SELECT * FROM ST3_SITE;

V_ST4_SITE C_SITE%ROWTYPE;


BEGIN
	OPEN C_SITE;
		LOOP
			FETCH C_SITE INTO V_ST4_SITE;
			EXIT WHEN C_SITE%NOTFOUND;

			INSERT INTO DIM_SITE
			VALUES
			(V_ST4_SITE.SK_SITE,
             V_ST4_SITE.Id,
			 V_ST4_SITE.Obra,
			 V_ST4_SITE.Bloco,
			 V_ST4_SITE.Unidade,
			 V_ST4_SITE.Nome,
             V_ST4_SITE.DocumentoSITE,
             V_ST4_SITE.PercentualParticipacao,
             V_ST4_SITE.Ativo);
		END LOOP;

		COMMIT;
	CLOSE C_SITE;
END;