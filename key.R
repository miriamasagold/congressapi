#===============================================================================
# set key function
#===============================================================================

congress_set_key <- function(key) {
  
  Sys.setenv("CONGRESS_API_KEY" = key)
  
  cat("API Key set:", key)
  
}

#===============================================================================
# retrieve key function
#===============================================================================

congress_get_key <- function() {
  
  Sys.getenv("CONGRESS_API_KEY")
  
}

congress_get_key()


