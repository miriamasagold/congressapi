
#==========================================
# congress_make_url
#==========================================

test_that("basic make_url works", {
  expect_equal(congress_make_url(""), "https://api.congress.gov/v3/")
})

test_that("one endpoint make_url works", {
  expect_equal(congress_make_url("bill"), "https://api.congress.gov/v3/bill")
})

test_that("two endpoints make_url works", {
  expect_equal(congress_make_url("bill/117"), "https://api.congress.gov/v3/bill/117")
})

test_that("endpoint with hyphen make_url works", {
  expect_equal(congress_make_url("congressional-record"), "https://api.congress.gov/v3/congressional-record")
})


#==========================================
# append_args
#==========================================

test_that("append_args takes one key-value pair", {
  expect_equal(append_args(list(a = 1, b = 2), c = 3),
               list(a = 1, b = 2, c= 3))
})

test_that("append_args takes multiple key-value pair", {
  expect_equal(append_args(list(a = 1, b = 2),
                          c = 3, d = 4, e = 5),
               list(a = 1, b = 2, c= 3,
                    d = 4, e = 5))
})




#==========================================
# extract_endpoint
#==========================================

test_that("no endpoint returns empty string", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/"),
               "")
})

test_that("extract_endpoint works with single item endpoint", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/bill"),
               "bill")
})

test_that("extract_endpoint works with single item and hanging slash", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/bill/"),
               "bill")
})

test_that("extract_endpoint works with n-item endpoint", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/bill/117/hr"),
               "bill")
})


test_that("extract_endpoint - to _ replacement works", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/house-communication"),
               "house_communication")
})

test_that("extract_endpoint - to _ replacement works, n-items", {
  expect_equal(extract_endpoint("https://api.congress.gov/v3/house-communication/117/ec/3324"),
               "house_communication")
})



#==========================================
# get_congress
#==========================================

test_that("bill endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("bill"),
                  "data.frame")
})

test_that("amendment endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("amendment"),
                  "data.frame")
})

test_that("summaries endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("summaries"),
                  "data.frame")
})

test_that("congress endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("congress"),
                  "data.frame")
})

test_that("member endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("member"),
                  "data.frame")
})

test_that("committee endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("committee"),
                  "data.frame")
})

test_that("committee-report endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("committee-report"),
                  "data.frame")
})

test_that("congressional-record endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("congressional-record"),
                  "data.frame")
})

test_that("house-communication endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("house-communication"),
                  "data.frame")
})

test_that("nomination endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("nomination"),
                  "data.frame")
})


test_that("treaty endpoint returns data.frame", {

  skip_on_cran()
  skip_if_key_missing()

  expect_s3_class(get_congress("treaty"),
                  "data.frame")
})





