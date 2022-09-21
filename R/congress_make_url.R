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

  final_list <-
    setNames(base_list, new_names)

  return(final_list)

}




