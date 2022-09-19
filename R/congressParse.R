
#===============================================================================
# Parse API response
#===============================================================================


extract_endpoint <- function(url) {

  pattern <- "(?<=v3/)[[:alpha:]-]*(?=/)"
  m <- regexpr(pattern, url,
               perl = TRUE)

  endpoint <- regmatches(url, m)

  cleaned <- gsub("-", "_", endpoint)

  return(cleaned)

}

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

  endpoint <- extract_endpoint(resp$url)

  # return congress_api S3 object
  structure(
    list(
      content = raw,
      path = resp$url,
      response = resp
    ),
    class = c("congress_api", endpoint)
  )

}

# S3 print method for congress_api class objects
print.congress_api <- function(x, ...) {

  cat("<Congress API: ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)

}






