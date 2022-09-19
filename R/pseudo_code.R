# pseudo code for congressGet()

congressGet <- function(endpoint,
                        key = Sys.getenv("CONGRESS_API_KEY"),
                        format = "json", ...) {

  full_url <- congress_make_url(endpoint)

  # checked_added_args <- argcheckfunc(...)

  query_list <-
    appendArgs(base_list = list(api_key = key,
                                format = format),
               args_to_add = checked_added_args)

  resp <- httr::GET(full_url,
                    query = query_list)

  # check_response()

  congressParse(resp, endpoint)

  # return dataframe

}

