DROP TABLE ST1_EMP;
DROP TABLE ST2_EMP;
DROP TABLE ST3_EMP;
DROP TABLE DIM_EMP;
DROP TABLE METADADO_EMP;

-- Satge 1 EMP
-- Criando a tabela emp no Stage 1 (Extraindo dados do Relacional para o ambiente Dimensional)
-- Tabelas são criadas como um "espelho" do modelo relacional, sem suas devidas constraints.

/*Extração dos dados*/

CREATE TABLE ST1_EMP
(
obra                              NUMBER(4) NOT NULL,
    bloco                             NUMBER(2) NOT NULL,
    unidade                           CHAR(6) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6),
    valorvenda                        NUMBER(15, 2),
    dataliberacaochaves               TIMESTAMP(6),
    formapagamento                    INTEGER,
    faseincorporacao                  CHAR(3),
    datacessao                        TIMESTAMP(6),
    datadesembolso                    TIMESTAMP(6),
    dataentregainicial                TIMESTAMP(6),
    datahabitese                      TIMESTAMP(6),
    statusdistrato                    CHAR(1),
    datachaves                        TIMESTAMP(6),
    indiceprechaves                   VARCHAR2(10),
    indiceposchaves                   VARCHAR2(10),
    debitoautomatico                  CHAR(1),
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    diasatraso                        INTEGER NOT NULL,
    valoratraso                       NUMBER(18, 2) NOT NULL,
    totalatraso                       NUMBER(18, 2) NOT NULL,
    crm_processamentopendente         CHAR(1) NOT NULL,
    crm_operacao                      CHAR(1) NOT NULL,
    crm_posicaofinanceiraid           VARCHAR2(40),
    createdon                         TIMESTAMP(6) NOT NULL,
    modifiedon                        TIMESTAMP(6) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6),
    valorpago                         NUMBER(13, 2),
    valorpagoatualizado               NUMBER(13, 2),
    tipopagamento                     CHAR(3),
    dataquitacao                      TIMESTAMP(6),
    valorquitacao                     NUMBER(13, 2),
    lr_tipocontrato                   VARCHAR2(3),
    lr_saldo                          NUMBER(13, 2),
    lr_datavencimento                 TIMESTAMP(6),
    lr_codigo                         VARCHAR2(20),
    lr_datarenegociacao               TIMESTAMP(6),
    pcvf_saldodevedor                 NUMBER(13, 2),
    pcvf_totalatraso                  NUMBER(13, 2),
    pcvu_saldodevedor                 NUMBER(13, 2),
    pcvu_totalatraso                  NUMBER(13, 2),
    pcvp_saldodevedor                 NUMBER(13, 2),
    pcvp_totalatraso                  NUMBER(13, 2),
    dec_saldodevedor                  NUMBER(13, 2),
    dec_totalatraso                   NUMBER(13, 2),
    mod_saldodevedor                  NUMBER(13, 2),
    mod_totalatraso                   NUMBER(13, 2),
    lig_saldodevedor                  NUMBER(13, 2),
    lig_totalatraso                   NUMBER(13, 2),
    tcs_saldodevedor                  NUMBER(13, 2),
    tcs_totalatraso                   NUMBER(13, 2),
    lot_saldodevedor                  NUMBER(13, 2),
    lot_totalatraso                   NUMBER(13, 2),
    crm_processamentopendenterepasse  CHAR(1) DEFAULT ( ( 0 ) ) NOT NULL,
    valortotalreceberobras            NUMBER(15, 2),
    valorparcelachaves                NUMBER(15, 2),
    valortotalposobra                 NUMBER(15, 2),
    dataultimaprestacaopaga           TIMESTAMP(6),
    dataultimaalteracao               TIMESTAMP(6)
)
;

/*Passo de coleta dos dados*/

DECLARE

  CURSOR C_emp
 IS 
      SELECT Id,
             obra,
             bloco,
             unidade,
             nome,
             CPF_CNPJ,
             PercentualParticipacao,
             Ativo
      FROM   Coobrigado;


      v_stage1_emp
     C_emp
    %ROWTYPE;


       BEGIN

           OPEN C_emp
        ;

    
            LOOP

               FETCH C_emp
             INTO v_stage1_emp
            ;

               EXIT WHEN C_emp
            %NOTFOUND;            

               INSERT INTO ST1_EMP

               (Id,
                Obra,
                Bloco,
                Unidade,
                NomeEMP
                Documentoemp
            ,
                PercentualParticipacao,
                Ativo)
                VALUES
               (v_stage1_emp
            .Id,
                v_stage1_emp
            .Obra,
                v_stage1_emp
            .Bloco,
                v_stage1_emp
            .Unidade,
                v_stage1_emp
            .Nome,
                v_stage1_emp
            .CPF_CNPJ,
                v_stage1_emp
            .PercentualParticipacao,
                v_stage1_emp
            .Ativo
	           );

      
             END LOOP;

       

             COMMIT;

       

           CLOSE C_emp
        ;

       

        END;
        
SELECT * FROM ST1_EMP;        

-- Stage 2 emp - Registrando os dados limpos.

CREATE TABLE ST2_EMP
(
    Id_EMP          integer NOT NULL,
    obra                              NUMBER(4) NOT NULL,
    bloco                             NUMBER(2) NOT NULL,
    unidade                           CHAR(6) NOT NULL,
    empresa                           NUMBER(4) NOT NULL,
    situacaounidade                   CHAR(2) NOT NULL,
    datavenda                         TIMESTAMP(6),
    valorvenda                        NUMBER(15, 2),
    dataliberacaochaves               TIMESTAMP(6),
    formapagamento                    INTEGER,
    faseincorporacao                  CHAR(3),
    datacessao                        TIMESTAMP(6),
    datadesembolso                    TIMESTAMP(6),
    dataentregainicial                TIMESTAMP(6),
    datahabitese                      TIMESTAMP(6),
    statusdistrato                    CHAR(1),
    datachaves                        TIMESTAMP(6),
    indiceprechaves                   VARCHAR2(10),
    indiceposchaves                   VARCHAR2(10),
    debitoautomatico                  CHAR(1),
    saldodevedor                      NUMBER(18, 2) NOT NULL,
    diasatraso                        INTEGER NOT NULL,
    valoratraso                       NUMBER(18, 2) NOT NULL,
    totalatraso                       NUMBER(18, 2) NOT NULL,
    crm_processamentopendente         CHAR(1) NOT NULL,
    crm_operacao                      CHAR(1) NOT NULL,
    crm_posicaofinanceiraid           VARCHAR2(40),
    createdon                         TIMESTAMP(6) NOT NULL,
    modifiedon                        TIMESTAMP(6) NOT NULL,
    dataprevisaoentrega               TIMESTAMP(6),
    valorpago                         NUMBER(13, 2),
    valorpagoatualizado               NUMBER(13, 2),
    tipopagamento                     CHAR(3),
    dataquitacao                      TIMESTAMP(6),
    valorquitacao                     NUMBER(13, 2),
    lr_tipocontrato                   VARCHAR2(3),
    lr_saldo                          NUMBER(13, 2),
    lr_datavencimento                 TIMESTAMP(6),
    lr_codigo                         VARCHAR2(20),
    lr_datarenegociacao               TIMESTAMP(6),
    pcvf_saldodevedor                 NUMBER(13, 2),
    pcvf_totalatraso                  NUMBER(13, 2),
    pcvu_saldodevedor                 NUMBER(13, 2),
    pcvu_totalatraso                  NUMBER(13, 2),
    pcvp_saldodevedor                 NUMBER(13, 2),
    pcvp_totalatraso                  NUMBER(13, 2),
    dec_saldodevedor                  NUMBER(13, 2),
    dec_totalatraso                   NUMBER(13, 2),
    mod_saldodevedor                  NUMBER(13, 2),
    mod_totalatraso                   NUMBER(13, 2),
    lig_saldodevedor                  NUMBER(13, 2),
    lig_totalatraso                   NUMBER(13, 2),
    tcs_saldodevedor                  NUMBER(13, 2),
    tcs_totalatraso                   NUMBER(13, 2),
    lot_saldodevedor                  NUMBER(13, 2),
    lot_totalatraso                   NUMBER(13, 2),
    crm_processamentopendenterepasse  CHAR(1) DEFAULT ( ( 0 ) ) NOT NULL,
    valortotalreceberobras            NUMBER(15, 2),
    valorparcelachaves                NUMBER(15, 2),
    valortotalposobra                 NUMBER(15, 2),
    dataultimaprestacaopaga           TIMESTAMP(6),
    dataultimaalteracao               TIMESTAMP(6)
)
;


/*Registrando os dados consistentes*/

DECLARE
	
    CURSOR C_Q_emp
 IS 
        SELECT * FROM ST1_EMP;
	
V_Q_emp C_Q_emp%ROWTYPE;

BEGIN
	OPEN C_Q_emp
;
		LOOPEMP
			FETCH C_Q_emp
         INTO V_Q_emp
        ;
			EXIT WHEN C_Q_emp
        %NOTFOUND;

			IF(V_Q_emp
        .Id IS NOT NULL) AND
              (V_Q_emp
            .Obra IS NOT NULL) AND
              (V_Q_emp
            .Bloco IS NOT NULL) AND
			  (V_Q_emp
            .Unidade IS NOT NULL) AND
			  (V_Q_emp
            .Nome IS NOT NULL) AND
			  (V_Q_emp
            .Documentoemp
             IS NOT NULL) AND
			  (V_Q_emp
            .PercentualParticipacao IS NOT NULL) AND
			  (V_Q_emp
            .Ativo IS NOT NULL) THEN

				INSERT INTO ST2_EMP
				VALUES
                (V_Q_emp
            .Id,
                 V_Q_emp
                .Obra,
                 V_Q_emp
                .Bloco,
                 V_Q_emp
                .Unidade,
                 V_Q_emp
                .Nome,
                 V_Q_emp
                .Documentoemp
                ,
                 V_Q_emp
                .PercentualParticipacao,
                 V_Q_emp
                .Ativo);

			END IF;
		END LOOP;
		
		COMMIT;

	CLOSE C_Q_emp
;
END;


-- Stage3 emp
-- Transformação dos dados

CREATE TABLE METADADO_EMP
(KEY_emp INTEGER,
PK_emp   INTEGER);


CREATE TABLE ST3_EMP
(
SK_emp                      integer NOT NULL,
Id      			           integer NOT NULL,
Obra    			           char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
Documentoemp 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NULL
)
;


DECLARE
	CURSOR C_emp
 IS
		SELECT * FROM ST2_EMP;
    

V_ST3_EMP  C_emp%ROWTYPE;
V_PK NUMBER;
V_SK NUMBER;


BEGIN
	OPEN C_emp
;
		LOOP
			FETCH C_emp
         INTO V_ST3_EMP;
			EXIT WHEN C_emp
        %NOTFOUND;

			SELECT COUNT(KEY_emp
        )
			INTO V_PK
			FROM METADADO_EMP
            WHERE V_ST3_EMP.ID = PK_emp
        ;

			IF V_PK = 0 THEN
				SELECT NVL(MAX(KEY_emp
            ),0)
				INTO V_SK
				FROM METADADO_EMP;
        

				V_SK := V_SK +1;

				INSERT INTO METADADO_EMP
				VALUES
				(V_SK,
				V_ST3_EMP.ID);


				INSERT INTO ST3_EMP
				VALUES
			        (V_SK,
                    V_ST3_EMP.Id,
			        V_ST3_EMP.Obra,
			        V_ST3_EMP.Bloco,
			        V_ST3_EMP.Unidade,
			        V_ST3_EMP.Nome,
                    V_ST3_EMP.Documentoemp
                ,
                    V_ST3_EMP.PercentualParticipacao,
                    V_ST3_EMP.Ativo);

			END IF;

		END LOOP;

		COMMIT;
	
	CLOSE C_emp
;

END;

SELECT * FROM ST3_EMP;

SELECT * FROM METADADO_EMP


--STAGE 4 

--Criacao da tabela de dimensao emp

CREATE TABLE DIM_EMP
(
SK_emp                     integer NOT NULL,
Id      			           integer NOT NULL,
Obra    			           char(4) NOT NULL,
Bloco   			           char(2) NOT NULL,
Unidade 			           char(6) NOT NULL,
Nome 				           varchar2(150) NOT NULL,
Documentoemp 			   varchar2(20) NOT NULL,
PercentualParticipacao         number(5, 2) NOT NULL,
Ativo 				           number NULL
);

DECLARE
	CURSOR C_emp
 IS
		SELECT * FROM ST3_EMP;

V_ST4_emp C_emp%ROWTYPE;


BEGIN
	OPEN C_emp
;
		LOOP
			FETCH C_emp
         INTO V_ST4_emp
        ;
			EXIT WHEN C_emp
        %NOTFOUND;


			INSERT INTO DIM_EMP
			VALUES
			(V_ST4_emp
        .SK_emp
        ,
             V_ST4_emp
            .Id,
			 V_ST4_emp
            .Obra,
			 V_ST4_emp
            .Bloco,
			 V_ST4_emp
            .Unidade,
			 V_ST4_emp
            .Nome,
             V_ST4_emp
            .Documentoemp
            ,
             V_ST4_emp
            .PercentualParticipacao,
             V_ST4_emp
            .Ativo);

		END LOOP;

		COMMIT;
	CLOSE C_emp
;

END;