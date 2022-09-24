skip_if_key_missing <- function() {

  testthat::skip_if(
    condition = (congress_get_key() == ""),
    message = "No Congress API Key Found."
  )

}
