#==========================================
# congress_get_key() tests
#==========================================

test_that("congress_set_key() works", {

  old_key <- congress_get_key()
  on.exit(congress_set_key(old_key),
          add = TRUE,
          after = FALSE)

  invisible(congress_set_key("new_key"))

  expect_identical(congress_get_key(), "new_key")

})

test_that("get_congress() throws error if no key has been set", {

  old_key <- congress_get_key()
  on.exit(congress_set_key(old_key),
          add = TRUE,
          after = FALSE)

  invisible(congress_set_key(""))

  expect_error(get_congress(endpoint = "bill"))

})
