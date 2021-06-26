/*Drop tables*/
DROP TABLE controlesessao;
DROP TABLE coobrigado;
DROP TABLE log_navegacao;
DROP TABLE parcela;
DROP TABLE posicaofinanceira;

/*CREATE SEQUENCES*/
CREATE SEQUENCE controlesessao_id_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE log_navegacao_id_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE coobrigado_id_seq START WITH 1 NOCACHE ORDER;

/*CREATE LOG_NAVEGACAO*/
CREATE TABLE log_navegacao (
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
ALTER TABLE log_navegacao ADD CONSTRAINT pk_log_navegacao PRIMARY KEY ( id );

/*CREATE TABLE CONTROLE SESSÃO*/
CREATE TABLE controlesessao (
    id              INTEGER NOT NULL,
    dataacesso      TIMESTAMP(6) NOT NULL,
    hash            VARCHAR2(256) NOT NULL,
    dataexpiracao   TIMESTAMP(6) NOT NULL,
    cliente         VARCHAR2(18) NOT NULL,
    tipoacesso      INTEGER NOT NULL,
    loginatendente  VARCHAR2(100),
    tiposessao      INTEGER,
    origem          INTEGER
);

ALTER TABLE controlesessao ADD CONSTRAINT pk_CONTROLESESSAO PRIMARY KEY ( id );

/*CREATE TABLE CLIENTES*/
CREATE TABLE coobrigado (
    id                      INTEGER NOT NULL,
    obra                    NUMBER NOT NULL,
    bloco                   NUMBER NOT NULL,
    unidade                 CHAR(6) NOT NULL,
    nome                    VARCHAR2(150) NOT NULL,
    cpf_cnpj                VARCHAR2(20) NOT NULL,
    percentualparticipacao  NUMBER(5, 2) NOT NULL,
    principal               INTEGER NOT NULL,
    createdon               TIMESTAMP(6),
    modifiedon              TIMESTAMP(6),
    ativo                   INTEGER,
    codclientesap           INTEGER
);

ALTER TABLE coobrigado ADD CONSTRAINT pk_coobrigado PRIMARY KEY ( id );

/*CREATE TABLE POSIÇÃO FINANCEIRA*/
CREATE TABLE posicaofinanceira (
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
);

ALTER TABLE posicaofinanceira
    ADD CONSTRAINT pk_posicaofinanceira PRIMARY KEY ( obra,
                                                      bloco,
                                                      unidade );

/*CREATR TABLE PARCELA*/
CREATE TABLE parcela (
    obra                       NUMBER(4) NOT NULL,
    bloco                      NUMBER(2) NOT NULL,
    unidade                    CHAR(6) NOT NULL,
    id_contrato_vencimento     VARCHAR2(50) NOT NULL,
    contrato                   VARCHAR2(20) NOT NULL,
    datavencimento             TIMESTAMP(6) NOT NULL,
    valorprestacao             NUMBER NOT NULL,
    principal                  NUMBER,
    jurostp                    NUMBER,
    variacoes                  NUMBER,
    seguros                    NUMBER,
    descontos                  NUMBER,
    multa                      NUMBER,
    jurosmora                  NUMBER,
    prorataindice              NUMBER,
    proratacontrato            NUMBER,
    valorpresente              NUMBER,
    indicereajuste             VARCHAR2(10),
    situacaoparcela            VARCHAR2(10),
    boletojm                   CHAR(1),
    vencimentojm               TIMESTAMP(6),
    periodicidade              VARCHAR2(10),
    tipocontrato               CHAR(3),
    tipoemprestimo             VARCHAR2(3),
    tipobloqueio               NUMBER(6),
    crm_processamentopendente  NUMBER(1) NOT NULL,
    crm_operacao               CHAR(1) NOT NULL,
    crm_parcelaid              VARCHAR2(40),
    createdon                  TIMESTAMP(6) NOT NULL,
    modifiedon                 TIMESTAMP(6) NOT NULL,
    geradopor                  VARCHAR2(80),
    idreneg                    INTEGER,
    datarenegociacao           TIMESTAMP(6),
    valorabono                 NUMBER(18, 2),
    valoracrescimo             NUMBER(18, 2),
    vlrabonomulta              NUMBER(18, 2),
    vlrabonojuros              NUMBER(18, 2),
    vlrabonoprorata            NUMBER(18, 2),
    tx_juros                   NUMBER(18, 2),
    tx_encargos                NUMBER(18, 2),
    motivorenegociacao         VARCHAR2(200)
);

ALTER TABLE parcela ADD CONSTRAINT pk_parcela PRIMARY KEY (id_contrato_vencimento);

CREATE TABLE T_MARCA (
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

ALTER TABLE T_MARCA ADD CONSTRAINT PK_MARCA PRIMARY KEY (CARTEIRA);

/*RELACIONANDO AS TABELAS*/

ALTER TABLE coobrigado
    ADD CONSTRAINT fk_coobrigado_posicaofinanceira FOREIGN KEY ( obra,
                                                                 bloco,
                                                                 unidade )
        REFERENCES posicaofinanceira ( obra,
                                           bloco,
                                           unidade );

ALTER TABLE parcela
    ADD CONSTRAINT fk_parcela_posicaofinanceira FOREIGN KEY ( obra,
                                                              bloco,
                                                              unidade )
        REFERENCES posicaofinanceira ( obra,
                                           bloco,
                                           unidade );


// triggers 
CREATE OR REPLACE TRIGGER controlesessao_id_trg BEFORE
    INSERT ON controlesessao
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := controlesessao_id_seq.nextval;
END;

CREATE OR REPLACE TRIGGER coobrigado_id_trg BEFORE
    INSERT ON coobrigado
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := coobrigado_id_seq.nextval;
END;

CREATE OR REPLACE TRIGGER log_navegacao_id_trg BEFORE
    INSERT ON log_navegacao
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := log_navegacao_id_seq.nextval;
END;
