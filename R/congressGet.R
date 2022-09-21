
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

