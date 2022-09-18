
#===============================================================================
# Generic GET request function
#===============================================================================

congressGet <-
  function(
    group = c(
      "bill", "amendment", "summaries",
      "congress", "member", "committee",
      "committeeReport", "congressional-record",
      "house-communication", "nomination", "treaty"
    ),
    key = congress_get_key(),
    group_args,
    ...
  ) {
    
    # Check group arg
    if(length(group) != 1) stop("'group' arg must be length 1", call. = FALSE)
    if(!(group %in% c("bill", "amendment", "summaries",
                      "congress", "member", "committee",
                      "committeeReport", "congressional-record",
                      "house-communication", "nomination", "treaty")
    )
    ) stop("'group' must be in 'bill', 'amendment', 'summaries'
    'congress', 'member', 'committee',
    'committeeReport', 'congressional-record',
    'house-communication', 'nomination', 'treaty'", call. = FALSE)
    
    
    
    # Check for key in environment
    if(is.null(key)) key <- congress_get_key()
    if(key == "") stop("The required 'key' argument is missing. A key may be requested at https://api.congress.gov/sign-up")
    
    
    # Make url
    base_url <- paste0("https://api.congress.gov/v3/",
                       group)
    
    # attach group arguments to URL
    full_url <- paste0(base_url, "/", group_args)
    
    # GET request
    req <- httr::GET(full_url, 
                     query = list(api_key = key,
                                  ...))
    
    return(req)
    
  }
