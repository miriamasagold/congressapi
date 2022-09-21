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

