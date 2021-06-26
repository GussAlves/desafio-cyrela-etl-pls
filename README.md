<h1 align="center">🚀 Desafio Cyrela - Dashboard Power BI 🚀</h1>

_Olá a todos!! Esse repositório tem como objetivo armazenar os scripts e dados utilizados para entrega do desafio Cyrela!_

## Cenario atual: 
A Cyrela possui diversas bases de dados, internas e externas, para alimentar seus sistemas e aplicativos. Os casos contidos nessas bases são valiosíssimos para auxiliar na tomada de decisões.

## Solução: 
Para que os dados possam ser utilizados na geração de relatórios relevantes eles precisam ser tratados, pensando nisso criamos um processo utilizando PL/SLQ, onde, os dados passam pelas etapas de _ETL_, conforme apresentadas abaixo: 

Fluxo de ETL detalhado 
![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/ETL_Process.PNG)

Após esse processo realizamos a carga para a Data Werehouse no Power BI, realizamos a construção do deshboard para exibição dos dados:
![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/dashboard_view.PNG)

Também está disponível clicando 
<a href="https://app.powerbi.com/view?r=eyJrIjoiNTg2MjdhNjAtMzhhOC00MWQyLWEzN2EtNzZmOGY5ZTk0MWJmIiwidCI6IjExZGJiZmUyLTg5YjgtNDU0OS1iZTEwLWNlYzM2NGU1OTU1MSIsImMiOjR9&pageName=ReportSection">aqui</a>

## Tecnologias:
Para esse projeto foi utilizado as seguintes tecnologias:

- [Oracle]   - Usado para armazenar os dados. <a href="https://docs.oracle.com/en/">Doc.</a>
- [Pl/Sql]   - Linguagem procedural para realizar a migração dos dados transformações de dados. <a href="https://docs.oracle.com/cd/E12151_01/index.htm">Doc.</a>
- [Power BI] - Data Werehouse - Utlizado para cruzar dados e gerar relatórios; <a href="https://docs.microsoft.com/pt-br/power-bi/">Doc.</a>

## Organização dos dados:
A Estrutura das tabelas segue o modelo relacional: 

![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/estrutura_projeto.png)

## Instalação 
- _Para realizar os projeto é necessário ter o banco de dados Oracle instalado_.

Após logar no banco, rode os script:
```sh
/database/script_create_database.sql
```

Após as criações da estrutura é necessário migrar os dados para base, podemos encontrar encontrar os arquivos no caminho abaixo: 

```sh
/*Tabelas em ordem de migração*/
/migrations/LOG_NAVEGACAO_202106191201.sql
/migrations/CONTROLESESSAO_202106191207.sql
/migrations/POSICAOFINANCEIRA_202106191207.sql
/migrations/COOBRIGADO_202106191207.sql
/migrations/PARCELA_202106191208.sql
```

Após finalizar o processo de migrações podemos rodar os scripts PL/SQL para realizar o processo de ETL nos dados, que se consiste em 4 stages, Extração, limpeza, transformação e carga. Podemos encontrar os scripts na pasta 
```sh
/scritps_ETL-plsql
```
