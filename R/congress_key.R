
#' Get and Set Congress API Key
#'
#' `congress_set_key()` takes a character string API key and saves it as the
#' environment variable "CONGRESS_API_KEY". If a key has already been set in the
#' session, `congress_set_key()` will warn and prompt the user to choose whether
#' to overwrite. New keys may be generated at
#' [https://api.congress.gov/sign-up/](https://api.congress.gov/sign-up/).
#'
#' `congress_get_key()` retrieves the environment variable.
#'
#' @param key Character string API key to be saved as environmental variable "CONGRESS_API_KEY".
#' @param warn Warn user when attempting to overwrite an existing key? If set
#' to TRUE, prompts user to decide whether to overwrite.
#' @return A character vector of the currently set API key.
#'
#' @examples
#' \dontrun{
#' congress_set_key("YOUR_API_KEY_HERE")
#' }

#' @export
congress_set_key <- function(key, warn = FALSE) {

  if (Sys.getenv("CONGRESS_API_KEY") != "" & warn == TRUE) {

    cat("Congress API key already set. Do you wish to overwrite the existing key?")

    resp <- readline("[Y/n]: ")

    if (resp == "Y") {
      Sys.setenv("CONGRESS_API_KEY" = key)

      cat("API Key set:", key)
    } else if (resp == "n") {

      cat("Existing key preserved.")

    } else {
      stop("Unknown character. Call `congress_set_key()` to retry.",
           call. = FALSE)
    }

  } else {

    Sys.setenv("CONGRESS_API_KEY" = key)

    cat("API Key set:", key)

  }


}



#' @rdname congress_set_key
#' @export
congress_get_key <- function() {

  env_key <- Sys.getenv("CONGRESS_API_KEY")

  if (env_key == "") {

    on.exit(
      message(
        "No API key discovered. A key may be requested at https://api.congress.gov/sign-up"
        )
    )
  }

    return(env_key)

  }
