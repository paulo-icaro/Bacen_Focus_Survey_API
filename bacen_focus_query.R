# ================================== #
# === QUERY FUNCTION - BACEN API === #
# ================================== #

# --- Script by Paulo Icaro ---#


library(dplyr)

# ============= #
# === Query === #
# ============= #
bacen_focus_query = function(expectation_type, ..., format = 'json', sample_top = 10, sample_min = 1, fields = NULL, series_name = 'all'){
  
  # ---------------------------------- #
  # --- Source Auxiliary Functions --- #
  # ---------------------------------- #
  # if(source_github == TRUE){
  #   tryCatch(expr = suppressWarnings(source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_API/main/bacen_focus_api.R')),
  #            error= function(e){message('Não foi possível acessar a função Bacen_Focus_API')})
  #   Sys.sleep(1.5)
  #   
  #   tryCatch(expr = suppressWarnings(source('https://raw.githubusercontent.com/paulo-icaro/Bacen_Focus_API/main/bacen_focus_url.R')),
  #            error = function(e){message('Não foi possível acessar a função Bacen_Focus_URL')})
  #   Sys.sleep(1.5)
  # }
  # 
  # Sys.sleep(1.5)
  
  
  # ------------------------------ #
  # --- Check Expectation Type --- #
  # ------------------------------ #
  if(!(expectation_type %in% c('ExpectativaMercadoMensais', 'ExpectativasMercadoSelic', 'ExpectativasMercadoTrimestrais'))){
    stop('\nPor favor, especifique uma série válida !\n')
  }
  
  # ----------------------- #
  # --- Data Extraction --- #
  # ----------------------- #
  message('Acessando o Focus ...\n')
  Sys.sleep(1)
  #url = bacen_focus_url(expectation_type, format, sample_top, sample_min, fields)
  #print(url)
  bacen_focus = bacen_focus_api(url = bacen_focus_url(expectation_type, format, sample_top, sample_min, fields))
  if(series_name != 'all'){bacen_focus = bacen_focus |> filter(Indicador %in% series_name)}
  
  
  # ----------------------- #
  # --- Applied Filters --- #
  # ----------------------- #
  bacen_focus = bacen_focus |> filter(...)
  
  
  # -------------- #
  # --- Output --- #
  # -------------- #
  return(bacen_focus)
}