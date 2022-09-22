congress_make_url <- function(endpoint) {

  base_url <- "https://api.congress.gov/v3"

  full_url <- paste(base_url, endpoint, sep = "/")

  return(full_url)

}

appendArgs <- function(base_list, ...) {

  args_to_add <- list(...)

  starting_length <- length(base_list)

  new_names <- c(names(base_list), names(args_to_add))

  for (i in seq_along(args_to_add)) {

    base_list[[i+starting_length]] <- args_to_add[[i]]

  }

  names(base_list) <- new_names

  return(base_list)

}


#===============================================================================
# Parse API response
#===============================================================================

extract_endpoint <- function(url) {

  pattern <- "(?<=v3/)[[:alpha:]-]*(?=/?)"
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

    stop("API response does not contain valid JSON.\nYour API call was: ",
         resp$url,
         call. = FALSE)

  } else {

    raw <- jsonlite::fromJSON(content)

  }

  endpoint <- extract_endpoint(resp$url)

  # return congress_api S3 object
  out <- structure(
    list(
      content = raw,
      path = resp$url,
      response = resp
    ),
    class = c("congress_api", endpoint)
  )

  return(out)
}

# S3 print method for congress_api class objects
print.congress_api <- function(x, ...) {

  cat("<Congress API: ", x$path, ">\n", sep = "")
  utils::str(x$content)
  invisible(x)

}

# based on https://github.com/hrecht/censusapi/blob/HEAD/R/getcensus_functions.R
check_response <- function(resp) {

  content <-
    httr::content(resp, as="text",
                  encoding = "UTF-8")

  if (resp$status_code != 200) {

    err_msg <-
      trimws(
        gsub("[\\{\\}\n\"]|(e|E)rror|:", "", content)
      )

    stop(
      paste0(err_msg,"\nYour API call was: ",
             resp$url),
      call. = FALSE)

  }

  if (identical(content, "")) {
    stop("No content was returned.\nYour API call was: ",
         resp$url,
         call. = FALSE)
  }


}















congressGet <-
  function(endpoint,
           key          = congress_get_key(),
           return.data  = TRUE,
           ...
  ) {

    # Check for key in environment
    if(key == "") {
      stop("Congress API key is missing. A key may be requested at https://api.congress.gov/sign-up")
      }

    # construct API request url
    full_url <- congress_make_url(endpoint)

    # construct list of additional arguments to pass after the endpoint
    query_list <-
      appendArgs(base_list = list(api_key = key,
                                  format = "json"),
                 args_to_add = ...)


    # send GET request
    resp <- httr::GET(full_url,
                      query = query_list)


    # Check response
    checked_resp <- check_response(resp)


    # parse response and create S3 class based on endpoint type
    parsed <- congressParse(resp)

    if (return.data) {

      # Extract dataframe
      df <- congressData(parsed)

      return(df)

    } else {

      # Return content from parsed response
      return(parsed)

    }

  }

