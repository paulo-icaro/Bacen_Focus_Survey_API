# Acessando dados do Boletim Focus do Banco Central do Brasil via API

2026-11-03

<!------------>

<!-- PARTE 1 -->

<!------------>

## Objetivo

<p>

      Este tutorial mostra como extrair dados da API do Banco Central
referente ao Boletim Focus. Os scripts
[**bacen_focus_url**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R')
and
[**bacen_focus_api**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R')
são fundamentais para o processo de extração. A primeira função é
responsável pela geração das os endereços URL onde os dados estão
contidos. Já a outra função fica encarregada de realizar a conexão com a
API, extrair as informações e convertê-las em um formato legível.\
      Além disso, a função
[**bacen_focus_query**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/blob/main/bacen_focus_query.R')
combina as funcionalidades anteriores de modo a simplificar o processo
de obtenção dos dados.\
      As seções a seguir detalham o funcionamento de cada script.

</p>

<!------------>

<!-- PART 2 -->

<!------------>

## Bacen Focus URL

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_focus_url (expectation_type, format, sample_top, sample_min, fields)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

    Nesta função, o usuário precisa especificar alguns argumentos para
criar a URL. São eles:

- `expectation_type`: indica qual conjunto de dados você deseja
  acessar[^1];
- `format`: `json` é o formato mais comum. Outros formatos disponíveis
  são: `xml`, `csv` e `html`;
- `sample_top`: representa a quantidade de projeções para cada
  entidade[^2];
- `sample_min`: o índice da primeira entidade a ser coletada;
- `fields` (*opcional*): permite selecionar as variáveis do conjunto de
  dados que você deseja obter. Caso nenhum argumento seja especificado,
  todas as variáveis[^3] disponíveis serão baixadas.

      Neste exemplo, suponha que desejamos recuperar o conjunto de dados
de expectativas trimestrais:

</p>

``` r
# -------------------------------- #
# --- Examplo - Geração da URL --- #
# -------------------------------- #

# --- Função Bacen_Focus_URL --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R') 

# --- Criar URL --- #
bacen_focus_quartely_url = 
  bacen_focus_url(expectation_type = 'ExpectativasMercadoTrimestrais',
                  format = 'json',
                  sample_top = 10,
                  sample_min = 0,
                  fields = NULL)
bacen_focus_quartely_url
```

    [1] "https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoTrimestrais?top=10$skip=-1&$format=json"

<!-------------->

<!--- PARTE 3 --->

<!-------------->

## Bacen_Focus_API

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_focus_api (url, use_httr, extra_attempts)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

      É bem simples utilizar a função. O usuário precisa apenas
especificar os seguintes argumentos:

- `url`: a URL criada anteriormente pela função **bacen_focus_url**;
- `use_httr`: escolha entre as funções [*httr*](https://httr.r-lib.org/)
  ou [*httr2*](https://httr2.r-lib.org/);
- `extra_attempts`: em caso de falha na conexão, informe quantas
  tentativas adicionais de conexão você deseja;

      Vejamos como obter o conjunto de dados trimestrais a partir da URL
gerada anteriormente:

</p>

``` r
# ----------------------------------- #
# --- Examplo - Conexão com a API --- #
# ----------------------------------- #

# --- Função Bacen Focus API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R')

# --- URL --- #
focus_url = 'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoTrimestrais?top=10$skip=-1&$format=json'

# --- Obtendo dados da API --- #
bacen_focus_dataset = bacen_focus_api(url = focus_url, use_httr = TRUE)
head(bacen_focus_dataset, n = 10)
```

       Indicador       Data DataReferencia  Media Mediana DesvioPadrao Minimo
    1       IPCA 2021-09-14         3/2021 2.6803  2.7549       0.2296 2.1201
    2       IPCA 2021-09-14         4/2021 1.4356  1.4418       0.2070 0.8120
    3       IPCA 2021-09-14         1/2022 1.2195  1.1645       0.2350 0.6210
    4       IPCA 2021-09-14         2/2022 0.7806  0.8021       0.2521 0.1753
    5       IPCA 2021-09-14         3/2022 0.8264  0.8122       0.2072 0.1488
    6       IPCA 2021-09-14         4/2022 1.1484  1.1684       0.2395 0.3403
    7       IPCA 2021-09-14         1/2023 1.0648  1.0583       0.1810 0.6012
    8       IPCA 2021-09-14         2/2023 0.7564  0.7459       0.1822 0.2602
    9       IPCA 2021-09-14         3/2021 2.6803  2.7549       0.2296 2.1201
    10      IPCA 2021-09-14         4/2021 1.4356  1.4418       0.2070 0.8120
       Maximo numeroRespondentes baseCalculo
    1  2.9891                117           1
    2  2.0133                116           1
    3  1.8511                107           1
    4  1.3558                105           1
    5  1.4775                104           1
    6  1.8509                104           1
    7  1.6591                 74           1
    8  1.2552                 72           1
    9  2.9891                117           0
    10 2.0133                116           0

<!--------------->

<!--- PARTE 4 --->

<!--------------->

## Bacen_Focus_Query

<!------------------------------------------->

<!--- Detalhamento Função Github Document --->

<!------------------------------------------->

``` r
bacen_focus_query (expectation_type, ..., format, sample_top, sample_min, fields, series_name, source_github)
```

<!------------------------------->

<!--- Detalhamento Função PDF --->

<!------------------------------->

<!-------------------------------->

<!--- Detalhamento Função HTML --->

<!-------------------------------->

<p>

      A função
[**bacen_focus_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')
combina as duas funções descritas anteriormente. No entanto, ela traz
algumas melhorias.\
      Primeiro, alguns argumentos básicos não precisam ser
especificados, uma vez que `format`, `sample_top`, `sample_min` e
`fields` já vêm predefinidos. Além disso, `series_name` é um novo
argumento que permite filtrar os dados, selecionando apenas as variáveis
desejadas.\
      Adicionalmente, o uso de reticências (`...`) possibilita consultas
mais refinadas, permitindo a inclusão de filtros extras. O argumento
`source_github` define se as funções
[**bacen_focus_url**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R')
e
[**bacen_focus_api**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R')
devem ser acessadas diretamente a partir deste repositório no GitHub.\
      Os filtros fornecidos por meio de (`...`) devem ser compatíveis
com os dados obtidos no processo de extração.

      Cada exemplo abaixo representa um processo de extração com uma
especificação de consulta diferente. Vamos conferir:

#### Apenas `expectation_type` é especificado

      Neste caso, todos os dados são recuperados.

</p>

``` r
# ------------------------- #
# --- Extração de Dados --- #
# ------------------------- #

# --- Função Bacen Focus API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Coletando dados da API --- #
bacen_focus_dataset = bacen_focus_query(expectation_type = 'ExpectativasMercadoTrimestrais')
head(bacen_focus_dataset, n = 10)
```

       Indicador       Data DataReferencia  Media Mediana DesvioPadrao Minimo
    1       IPCA 2021-09-14         3/2021 2.6803  2.7549       0.2296 2.1201
    2       IPCA 2021-09-14         4/2021 1.4356  1.4418       0.2070 0.8120
    3       IPCA 2021-09-14         1/2022 1.2195  1.1645       0.2350 0.6210
    4       IPCA 2021-09-14         2/2022 0.7806  0.8021       0.2521 0.1753
    5       IPCA 2021-09-14         3/2022 0.8264  0.8122       0.2072 0.1488
    6       IPCA 2021-09-14         4/2022 1.1484  1.1684       0.2395 0.3403
    7       IPCA 2021-09-14         1/2023 1.0648  1.0583       0.1810 0.6012
    8       IPCA 2021-09-14         2/2023 0.7564  0.7459       0.1822 0.2602
    9       IPCA 2021-09-14         3/2021 2.6803  2.7549       0.2296 2.1201
    10      IPCA 2021-09-14         4/2021 1.4356  1.4418       0.2070 0.8120
       Maximo numeroRespondentes baseCalculo
    1  2.9891                117           1
    2  2.0133                116           1
    3  1.8511                107           1
    4  1.3558                105           1
    5  1.4775                104           1
    6  1.8509                104           1
    7  1.6591                 74           1
    8  1.2552                 72           1
    9  2.9891                117           0
    10 2.0133                116           0

### Campos também informados

<p>

      Neste caso, selecionamos apenas o índice, a data da pesquisa, a
data de referência e a mediana.

</p>

``` r
# ------------------------- #
# --- Extração de Dados --- #
# ------------------------- #

# --- Função Bacen Focus API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Coletando dados da API --- #
bacen_focus_dataset = 
  bacen_focus_query(expectation_type = 'ExpectativasMercadoTrimestrais',
                    fields = 'Indicador,Data,DataReferencia,Mediana')
head(bacen_focus_dataset, n = 10)
```

       Indicador       Data DataReferencia Mediana
    1       IPCA 2021-09-14         3/2021  2.7549
    2       IPCA 2021-09-14         4/2021  1.4418
    3       IPCA 2021-09-14         1/2022  1.1645
    4       IPCA 2021-09-14         2/2022  0.8021
    5       IPCA 2021-09-14         3/2022  0.8122
    6       IPCA 2021-09-14         4/2022  1.1684
    7       IPCA 2021-09-14         1/2023  1.0583
    8       IPCA 2021-09-14         2/2023  0.7459
    9       IPCA 2021-09-14         3/2021  2.7549
    10      IPCA 2021-09-14         4/2021  1.4418

### Filtragem adicional na consulta

<p>

      Suponha que nos interessem apenas as previsões para o primeiro
trimestre de 2025 referentes ao IPCA (índice de preços ao consumidor) e
à taxa de câmbio do Brasil. Além disso, essas previsões foram feitas
entre o dia primeiro e 15 de dezembro.

</p>

``` r
# ----------------------- #
# --- Data Extraction --- #
# ----------------------- #

# --- Função Bacen Focus API --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Coletando dados da API --- #
bacen_focus_dataset = 
  bacen_focus_query(expectation_type = 'ExpectativasMercadoTrimestrais',
                    DataReferencia == '1/2025',
                    Data > '2024-12-01',
                    Data < '2024-12-15',
                    Indicador %in% c('IPCA', 'PIB Toal'),
                    fields = 'Indicador,Data,DataReferencia,Mediana')
bacen_focus_dataset
```

       Indicador       Data DataReferencia Mediana
    1       IPCA 2024-12-02         1/2025  1.5646
    2       IPCA 2024-12-02         1/2025  1.5807
    3       IPCA 2024-12-03         1/2025  1.5613
    4       IPCA 2024-12-03         1/2025  1.5806
    5       IPCA 2024-12-04         1/2025  1.5647
    6       IPCA 2024-12-04         1/2025  1.5806
    7       IPCA 2024-12-05         1/2025  1.5851
    8       IPCA 2024-12-05         1/2025  1.5851
    9       IPCA 2024-12-06         1/2025  1.6208
    10      IPCA 2024-12-06         1/2025  1.5934
    11      IPCA 2024-12-09         1/2025  1.6435
    12      IPCA 2024-12-09         1/2025  1.6182
    13      IPCA 2024-12-10         1/2025  1.6436
    14      IPCA 2024-12-10         1/2025  1.6182
    15      IPCA 2024-12-11         1/2025  1.6436
    16      IPCA 2024-12-11         1/2025  1.6182
    17      IPCA 2024-12-12         1/2025  1.6484
    18      IPCA 2024-12-12         1/2025  1.6208
    19      IPCA 2024-12-13         1/2025  1.6926
    20      IPCA 2024-12-13         1/2025  1.6386

[^1]: A API Focus Survey possui os seguintes tipos de expectativa, cada
    um correspondendo a um horizonte ou nível de detalhamento de dados
    diferente: `ExpectativaMercadoMensais`, `ExpectativasMercadoSelic`,
    `ExpectativasMercadoTrimestrais`, `ExpectativasMercadoAnuais`,
    `ExpectativasMercadoInflacao12Meses`,
    `ExpectativasMercadoInflacao24Meses`,
    `ExpectativasMercadoTop5Mensais`, `ExpectativasMercadoTop5Selic`,
    `ExpectativaMercadoTop5Trimestral`, `ExpectativasMercadoTop5Anuais`,
    `ExpectativasMercadoTop5Inflacao12Meses`,
    `ExpectativasMercadoTop5Inflacao24Meses`. Clique
    [aqui]('https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/aplicacao#!/recursos')
    para mais detalhes.

[^2]: Uma entidade é uma combinação de dados definida com base nos
    campos (`fields`) selecionados.

[^3]: Cada `expectation_type` possui suas próprias variáveis.
