#===============================================================================
# set key function
#===============================================================================

congress_set_key <- function(key) {

  if (Sys.getenv("CONGRESS_API_KEY") != "") {

    cat("Congress API already set. Do you wish to overwrite the existing key?")

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

#===============================================================================
# retrieve key function
#===============================================================================

congress_get_key <- function() {

  env_key <- Sys.getenv("CONGRESS_API_KEY")

  if (env_key == "") {

    stop("No API key discovered. A key may be requested at https://api.congress.gov/sign-up",
         call. = FALSE)

  } else {

    env_key

  }

}

congress_get_key()


