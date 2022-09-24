
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
# appendArgs
#==========================================

test_that("appendArgs takes one key-value pair", {
  expect_equal(appendArgs(list(a = 1, b = 2), c = 3),
               list(a = 1, b = 2, c= 3))
})

test_that("appendArgs takes multiple key-value pair", {
  expect_equal(appendArgs(list(a = 1, b = 2),
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
# congressGet
#==========================================

test_that("", {

  skip_if_key_missing()

  expect_s3_class(congressGet("bill"),
                  "data.frame")
})









