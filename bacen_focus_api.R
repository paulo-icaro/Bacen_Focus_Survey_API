# =================================================== #
# === DATA COLLECT FUNCTION - BACEN BOLETIM FOCUS === #
# =================================================== #

# --- Script by Paulo Icaro ---#



# ---------------------------- #
# --- Packages e Libraries --- #
# ---------------------------- #
#install.packages(c('httr', 'httr2', 'jsonlite'))
library(httr)                               # API Connection (Base Version): https://httr.r-lib.org/
library(httr2)                              # API Connection (Modern Version): https://httr2.r-lib.org/
library(jsonlite)                           # Convert Json data to an objetc
library(dplyr)                              # Library for data manipulation
library(svDialogs)                          # Library for displaying message boxes



# -------------------------------- #
# --- API - Gathering Function --- #
# -------------------------------- #

bacen_focus_api = function(url, use_httr = TRUE, extra_attempts = 3){
  flag = 0
  
  # --- API Connection - Using httr --- #
  if(use_httr == TRUE){
    
    # -- API Connection -- # 
    api_connection = tryCatch(expr = GET(url = url),
                              error = function(e){message(paste0('Não foi possível realizar a conexão com a API. ', extra_attempts, ' novas tentativas serão feitas.\n'))},
                              call = NULL)
    Sys.sleep(1.2)
    
    # --- Missed Connection - Extra Attempts --- #
    if(is.null(api_connection) || api_connection$status_code != 200){
      while(flag < extra_attempts & (is.null(api_connection) || api_connection$status_code != 200)){
        flag = flag + 1
        api_connection = tryCatch(expr = GET(url = url),
                                  error = function(e){message('Falha na conexão. Tentando novamente ...\n')},
                                  call = NULL)
        Sys.sleep(max(1, flag)) # Progressive delay
      }
      
      # --- Fail Case --- #
      if(is.null(api_connection)){stop(paste0('Não foi possível estabelecer conexão com a API após ', extra_attempts, ' tentativas. Verifique sua conexão de internet e também se a URL de consulta é válida.\n'), call. = FALSE)}
      if(api_connection$status_code != 200){stop(paste0('Status code ', api_connection$status_code, '. A API pode estar temporariamente indisponível. Tente novamente mais tarde.\n'), call. = FALSE)}
    }
    
    
    # --- Successfull Case --- #
    else{message('Conexão bem sucedida !\n')}
    Sys.sleep(1)
    
    
    # --- Converting Data to a Readable Format --- #
    api_connection = rawToChar(api_connection$content)              # Raw to Json
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Json to Dataframe
    api_connection = api_connection$value                           # Values Dataframe
    
    
    # --- Output --- #
    return(api_connection)
  }
  
  
  
  # --- API Connection - Using httr2 --- #
  else if (use_httr == FALSE) {
    
    # -- API Connection -- # 
    api_connection = tryCatch(expr = request(base_url = url) %>% req_perform(),
                              error = function(e){message(paste0('Não foi possível realizar a conexão com a API. ', extra_attempts, ' novas tentativas serão feitas.\n'))},
                              call = NULL)
    
    
    # --- Missed Connection - Extra Attempts --- #
    if(is.null(api_connection) || api_connection$status_code != 200){
      while(flag < extra_attempts & (is.null(api_connection) || api_connection$status_code != 200)){
        flag = flag + 1
        api_connection = tryCatch(expr = request(base_url = url) %>% req_perform(),
                                  error = function(e){message('Falha na conexão. Tentando novamente ...\n')},
                                  call = NULL)
        Sys.sleep(max(1, flag)) # Progressive delay
      }
      
      # --- Fail Case --- #
      if(is.null(api_connection)){stop(paste0('Não foi possível estabelecer conexão com a API após ', extra_attempts, ' tentativas. Verifique sua conexão de internet e também se a URL de consulta é válida.\n'), call. = FALSE)}
      if(api_connection$status_code != 200){stop(paste0('Status code ', api_connection$status_code, '. A API pode estar temporariamente indisponível. Tente novamente mais tarde.\n'), call. = FALSE)}
    }
    
    
    # --- Successfull Case --- #
    else{message('Conexão bem sucedida !\n')}
    Sys.sleep(1)
    
    
    # --- Converting Data to a Readable Format --- #
    api_connection = rawToChar(api_connection$body)                 # Raw to JSon
    api_connection = fromJSON(api_connection, flatten = TRUE)       # Json to Dataframe
    api_connection = api_connection$value                           # Values Dataframe
    
    
    # --- Output --- #
    return(api_connection)
  }
  
  
  # --- Not specfified httr case --- #
  else{message('Argumento httr inválido ! Use TRUE para httr ou FALSE para htrr2.')}
}