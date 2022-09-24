#==========================================
# api key tests
#==========================================

test_that("congress_set_key() works", {

  on.exit(congress_set_key(""),
          add = TRUE,
          after = FALSE)

  congress_set_key("new_key")

  expect_identical(congress_get_key(), "new_key")

})

test_that("congressGet() throws error if no key has been set", {

  on.exit(congress_set_key(""),
          add = TRUE,
          after = FALSE)

  congress_set_key("")

  expect_error(congressGet(endpoint = "bill"))

})
