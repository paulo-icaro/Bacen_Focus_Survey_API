# ===================================================== #
# === URL GENERATION FUNCTION - BACEN BOLETIM FOCUS === #
# ===================================================== #

# --- Script by Paulo Icaro --- #


# ------------------ #
# --- URL Models --- #
# ------------------ #
#url_expect_inf_12m = 'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoInflacao12Meses'

# --------------------------------- #
# --- URL's Generation Function --- #
# --------------------------------- #
bacen_focus_url = function(expectation_type, format, sample_top, sample_min, fields){
  base_url = 'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/'
  
  if(expectation_type == 'ExpectativasMercadoTrimestrais'){
    # Main_URL
    focus_url = paste0(base_url, expectation_type, '?top=', sample_top, '$skip=', sample_min - 1, '&$format=', format)
    
    # Fields
    if(!is.null(fields)){focus_url = paste0(focus_url, '&$select=', fields)}
  }
  
  # Output
  return(focus_url)
}