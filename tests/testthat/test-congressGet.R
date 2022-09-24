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


test_that("number of colums in bill", {
  expect_length(names(congressGet("bill")),
                12)
})

test_that("number of colums in amendments", {
  expect_length(names(congressGet("amendment",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                10)
})

test_that("number of colums in summaries", {

  expect_length(names(congressGet("summaries",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                16)
})

test_that("number of colums in congress", {
  expect_length(names(congressGet("congress",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                8)
})

test_that("number of colums in member", {
  expect_length(names(congressGet("member",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                12)
})

test_that("number of colums in committee", {
  expect_length(names(congressGet("committee",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                11)
})

test_that("number of colums in committeeReport", {
  expect_length(names(congressGet("committeeReport",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                3)
})

#test_that("number of colums in congressional-record", {
#  expect_length(names(congressGet("congressional-record",
#                                 key = Sys.getenv("CONGRESS_API_KEY"))),
#                12)
#})

test_that("number of colums in house-communication", {
  expect_length(names(congressGet("house-communication",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                6)
})

test_that("number of colums in nomination", {
  expect_length(names(congressGet("nomination",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                13)
})

test_that("number of colums in treaty", {
  expect_length(names(congressGet("treaty",
                                  key = Sys.getenv("CONGRESS_API_KEY"))),
                10)
})












