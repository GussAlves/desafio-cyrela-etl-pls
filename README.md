<h1 align="center">🚀 Desafio Cyrela - Dashboard Power BI 🚀</h1>

_Olá a todos!! Esse repositório tem como objetivo armazenar os scripts e dados utilizados para entrega do desafio Cyrela!_

## Cenario atual: 
A Cyrela possui diversas bases de dados, internas e externas, para alimentar seus sistemas e aplicativos. Os casos contidos nessas bases são valiosíssimos para auxiliar na tomada de decisões.

## Solução: 
Para que os dados possam ser utilizados na geração de relatórios relevantes eles precisam ser tratados, pensando nisso criamos um processo utilizando PL/SLQ, onde, os dados passam pelas etapas de _ETL_, conforme apresentadas abaixo: 

 > _Fluxo de ETL detalhado_ 
![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/ETL_Process.PNG)

 - Após esse processo, realizamos a carga para a Data Warehouse no Power BI - ambiente utilizado para construção da dashboard com a respectiva exibição dos dados escolhidos cujo diferencial se apresenta na representação tanto geral/ampla dos negócios das Cyrela quanto específica de cada marca integrante da instituição

![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/dashboard_view.PNG)

-> Para melhor visualização das informações supramencionadas, <a href="https://app.powerbi.com/view?r=eyJrIjoiNTg2MjdhNjAtMzhhOC00MWQyLWEzN2EtNzZmOGY5ZTk0MWJmIiwidCI6IjExZGJiZmUyLTg5YjgtNDU0OS1iZTEwLWNlYzM2NGU1OTU1MSIsImMiOjR9&pageName=ReportSection">acesse este link</a> 📉 

## Tecnologias:
Para esse projeto foi utilizado as seguintes tecnologias:

- [Oracle]   - Função de armazenamento dos dados e geração de histórico das tabelas. - :closed_book:<a href="https://docs.oracle.com/en/">doc.</a>
- [Pl/Sql]   - Linguagem procedural para realizar a migração dos dados transformações de dados. :closed_book:<a href="https://docs.oracle.com/cd/E12151_01/index.htm">Doc.</a>
- [Power BI] - Data Warehouse - Integração/relacionamento de dados e geração de relatórios; :closed_book:<a href="https://docs.microsoft.com/pt-br/power-bi/">Doc.</a>

## Organização dos dados:
A estrutura das tabelas segue o modelo relacional abaixo:

![alt text](https://raw.githubusercontent.com/GussAlves/desafio-cyrela-etl-pls/main/_img/estrutura_projeto.png)

## Instalação 
- Para realizar a construção do projeto, é necessário que se tenha o banco de dados Oracle instalado em sua máquina.

> Após logar no banco, rode o seguinte script:
```sh
/database/script_create_database.sql
```
> Rodou? Boaaa! Agora, após a criação da estrutura, é necessário migrar os dados para base. "Mas onde posso encontrar esse dados?". Podemos encontrar esses dados nos arquivos que estão nos caminhos abaixo:

```sh
/*Tabelas em ordem de migração*/
/migrations/LOG_NAVEGACAO_202106191201.sql
/migrations/CONTROLESESSAO_202106191207.sql
/migrations/POSICAOFINANCEIRA_202106191207.sql
/migrations/COOBRIGADO_202106191207.sql
/migrations/PARCELA_202106191208.sql
```

> Muito bom! Sigamos, então, da seguinte maneira: Finalizados os processos de migração, podemos rodar os scripts PL/SQL para realizar o famoso de ETL nos dados, que se consiste em 3 stages denominados como Extração, Transformação e Carga. "Como eu posso encontrar tais scripts, Vision?" Dê uma olhada nesta pasta:

```sh
/scritps_ETL-plsql
```
Pronto! Está tudo bem feito! Espero que você tenha gostado. Para mais informações ou dúvidas sobre esse projeto, fale entre em contato 
