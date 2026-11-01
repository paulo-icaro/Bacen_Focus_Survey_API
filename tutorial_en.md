# Extracting Focus Survey Data via API

2026-10-28

<!------------>

<!-- PART 1 -->

<!------------>

## Purpose

<p>

      This tutorial shows how to extract the Focus Survey data from the
Central Bank of Brazil’s API. Two R scripts, which are
[**bacen_focus_url**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R')
and
[**bacen_focus_api**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R').
The first script generates the respective URL address while the latter
connects with the API, extracts the info required and converts it to a
readable format.\
      On top of that, the
[**bacen_query**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/blob/main/bacen_focus_query.R')
function combines the both previous functions into a single interface,
simplifying the data retrieval process.\
      The following sections describe how each function works.

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

      In this function the user has to specify a few arguments to create
URL. They are:

- `expectation_type`: inform which dataset you want to access[^1];
- `format`: json is the most common format. Other formats are: xml, csv
  and html;
- `sample_top`: the amount of forecasts for each entity[^2];
- `sample_min`: index of the first identity to be collected;
- `fields` (*optional*): select the variables of the dataset you want to
  retrieve. In case you do not specify any arguments, all variables[^3]
  available are downloaded.

      For this instance, suppose we want to retrieve the quartely
expectation dataset:

</p>

``` r
# -------------------------------- #
# --- Example - URL Generation --- #
# -------------------------------- #

# --- Bacen_Focus_URL Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R') 

# --- Create URL --- #
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

<!--- PART 3 --->

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

      It is simple to use the function. The user only has to specify the
following arguments:

- `url`: the URL previously created by the **bacen_focus_url** function;
- `use_httr`: choose between the [*httr*](https://httr.r-lib.org/) or
  [*httr2*](https://httr2.r-lib.org/) functions;
- `extra_attempts`: in case of missed connection, inform how many
  connections attempts you want;

      Let’s get the quartely dataset from the previous url:

</p>

``` r
# -------------------------------- #
# --- Example - API Connection --- #
# -------------------------------- #

# --- Bacen API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R')

# --- URL --- #
focus_url = 'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoTrimestrais?top=10$skip=-1&$format=json'

# --- Acessing API Data --- #
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

<!-------------->

<!--- PART 4 --->

<!-------------->

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

      The
[**bacen_focus_query**]('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')
combines the two previously described functions. However, it introduces
a few improvements.\
      First, some basic arguments do not need to be specified, as
`format`, `sample_top`, `sample_min` and `fields` are predefined.
Additionaly, `series_name` is a new argument that allows users to subset
the data by selecting only desired variables.\
      Furthermore, the ellipsis (`...`) enables more refined queries by
allowing users to specify additional filters. The `source_github`
argument determines whether
[**bacen_focus_url**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_url.R')
and
[**bacen_focus_api**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_api.R')
should be accessed directly from this Github repository.\
      The filters supplied through (`...`) must be compatible with the
data retrieved in the extraction process.

      Each case bellow represents an extraction process with a different
query specification. Let’s take a look:

#### Only `expectation_type` is specified

      In this case, all data is retrieved.

</p>

``` r
# ----------------------- #
# --- Data Extraction --- #
# ----------------------- #

# --- Bacen API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Acessing API Data --- #
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

### Fields also informed

<p>

      In this case, we only select the index, survey date, reference
date, and median..

</p>

``` r
# ----------------------- #
# --- Data Extraction --- #
# ----------------------- #

# --- Bacen API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Acessing API Data --- #
bacen_focus_dataset = bacen_focus_query(expectation_type = 'ExpectativasMercadoTrimestrais', fields = 'Indicador,Data,DataReferencia,Mediana')
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

### Extra filtering in the query

<p>

      Suppose we are only interested in forecasts for the first quarter
of 2025 regarding Brazil’s IPCA (consumer price index) and exchange
rate. Furthermore, these forecasts were made between December 01 and
December 15.

</p>

``` r
# ----------------------- #
# --- Data Extraction --- #
# ----------------------- #

# --- Bacen API Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_Survey_API/main/bacen_focus_query.R')


# --- Acessing API Data --- #
bacen_focus_dataset = bacen_focus_query(expectation_type = 'ExpectativasMercadoTrimestrais', DataReferencia == '1/2025',  Data > '2024-12-01', Data < '2024-12-15', Indicador %in% c('IPCA', 'PIB Toal'), fields = 'Indicador,Data,DataReferencia,Mediana')
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

[^1]: The Focus Survey API has the following expectation type, each for
    a different horizon or data refinement: `ExpectativaMercadoMensais`,
    `ExpectativasMercadoSelic`, `ExpectativasMercadoTrimestrais`,
    `ExpectativasMercadoAnuais`, `ExpectativasMercadoInflacao12Meses`,
    `ExpectativasMercadoInflacao24Meses`,
    `ExpectativasMercadoTop5Mensais`, `ExpectativasMercadoTop5Selic`,
    `ExpectativaMercadoTop5Trimestral`, `ExpectativasMercadoTop5Anuais`,
    `ExpectativasMercadoTop5Inflacao12Meses`,
    `ExpectativasMercadoTop5Inflacao24Meses`. Click
    [here]('https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/aplicacao#!/recursos')
    for more details.

[^2]: Data combination based on fields argument.

[^3]: Each `expectation_type` has its own variables.
