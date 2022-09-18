
#===============================================================================
# Parse API response
#===============================================================================

congressParse <- function(resp) {
  
  content <- httr::content(resp, 
                           as = "text", 
                           encoding = "UTF-8")
  
  validate <- 
    jsonlite::validate(content)[1]
  
  if (!validate) {
    
    # error message
    
  } else {
    
    raw <- jsonlite::fromJSON(content)
    
  }
  
  # return congress_api S3 object
  structure(
    list(
      content = raw,
      path = resp$request$url,
      response = resp
    ),
    class = "congress_api"
  )

}

# S3 print method for congress_api class objects
print.congress_api <- function(x, ...) {
  
  cat("<Congress API: ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
  
}






