# Extracting Focus Survey data via API

2026-10-28

<!------------>

<!-- PART 1 -->

<!------------>

## Purpose

<p>

      This tutorial shows how to extract the Focus Survey data from the
Central Bank of Brazil’s API. Two R scripts, which are
[**bacen_focus_url**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/blob/main/bacen_focus_url.R')
and
[**bacen_focus_api**]('https://github.com/paulo-icaro/Bacen_Focus_Survey_API/blob/main/bacen_focus_api.R').
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
