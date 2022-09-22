
# Internal: Constructs full url by pasting base API url to endpoint, like "bill/117"
congress_make_url <- function(endpoint) {

  base_url <- "https://api.congress.gov/v3"

  full_url <- paste(base_url, endpoint, sep = "/")

  return(full_url)

}

# Internal: appends name dot arguments to base list of additional arguments, like api_key
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


# Internal: extracts base endpoint ("bill") from API call ("https://api.congress.gov/v3/bill?api_key=API_KEY&format=json")
extract_endpoint <- function(url) {

  pattern <- "(?<=v3/)[[:alpha:]-]*(?=/?)"
  m <- regexpr(pattern, url,
               perl = TRUE)

  endpoint <- regmatches(url, m)

  cleaned <- gsub("-", "_", endpoint)

  return(cleaned)

}



# Internal: validates response to API call and throws error if content is empty or errorful
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

# Internal: parses API response and returns an S3 object of class 'endpoint' (e.g., "member")
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


## Internal:  S3 print method for congress_api class objects
print.congress_api <- function(x, ...) {

  cat("<Congress API: ", x$path, ">\n", sep = "")
  utils::str(x$content)
  invisible(x)

}



#' Retrieve data from official Congress API
#'
#' `congressGet` takes in a Congress API endpoint and returns data on bills,
#' amendments, congressional records, and other content.
#'
#' @param endpoint Character string, complete endpoint path.
#' @param key Character string, Congress API key. Defaults to congress_get_key()
#' @param return.data Logical, whether to parse JSON returned by API call into tabular format and return data.frame object. Not all endpoints are supported (e.g., "member/{bioguideId}"). In this case, the call will return JSON and throw a non-fatal warning.
#' @param ... Additional formatting options passed to the end of the API call (e.g., `sort = "desc"`). Arguments passed via dots must be named.
#'
#' @details 11 base endpoints may be specified: bill, amendments, summaries,
#' congress, member, committee, committeeReport, congressional-record,
#' house-communication, nomination, and treaty.
#'
#' Within each endpoint, multiple additional parameters may be specified to
#' filter data based on, for example, congressional session or chamber ("hr" vs. "s").
#' In addition, additional sorting and subsetting parameters may be passed through `...`,
#' such as `sort = "desc"` or `fromDateTime = "2022-04-01T00:00:00Z"`.
#' Pagination may be executed using `offset`. Amount of rows returned may be increased
#' using `limit`.
#'
#' Visit [https://api.congress.gov/](https://api.congress.gov/) for more details.
#'
#' @return If return.data = TRUE, returns a data.frame object of 20 rows by default. Otherwise, a JSON structure is returned.
#'
#' @examples
#' \dontrun{
#' congressGet("bill")
#' congressGet("congress/116")
#' congressGet("member/L000174", return.data = FALSE)
#' congressGet("committeeReport/116/hrpt/617/text")
#' }
#' @export

congressGet <-
  function(
    endpoint,
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

