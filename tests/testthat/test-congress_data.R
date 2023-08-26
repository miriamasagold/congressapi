# rename_nested

test_that("rename_nested works", {

  skip_on_cran()

  bill <- get_congress("bill", return.data = F)

  dat <- bill$content$bills

  expect_s3_class(
    rename_nested(
      .data = dat,
      col = "latestAction"
    ),
    "data.frame"
  )

})


# replace_empty

test_that("replace_empty works", {

  dat <- c("", "x", 1)

  expect_identical(
    replace_empty(x = dat, empty_char = ""),
    c(NA, "x", 1)
  )

})

#==========================================
# congress_data
#==========================================

test_that("congress_data works for bill", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("bill", return.data = FALSE)

  resp_df <- resp[['content']][['bills']]

  if (is.null(resp_df)) {

    expect_message(congress_data.bill(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.bill(resp))

  } else {

    expect_s3_class(
      congress_data.bill(resp),
      "data.frame"
    )

  }

})

test_that("congress_data works for amendment", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("amendment", return.data = FALSE)

  resp_df <- resp[['content']][['amendments']]

  if (is.null(resp_df)) {

    expect_message(congress_data.amendment(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.amendment(resp))

  } else {

    expect_s3_class(
      congress_data.amendment(resp),
      "data.frame"
    )

  }

})

test_that("congress_data works for summaries", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("summaries", return.data = FALSE)

  resp_df <- resp[['content']][['summaries']]

  if (is.null(resp_df)) {

    expect_message(congress_data.summaries(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.summaries(resp))

  } else {

    expect_s3_class(
      congress_data.summaries(resp),
      "data.frame"
    )

  }

})


test_that("congress_data works for congress", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("congress", return.data = FALSE)

  resp_df <- resp[['content']][['congresses']]

  if (is.null(resp_df)) {

    expect_message(congress_data.congress(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.congress(resp))

  } else {

    expect_s3_class(
      congress_data.congress(resp),
      "data.frame"
    )

  }

})



test_that("congress_data works for member", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("member", return.data = FALSE)

  resp_df <- resp[['content']][['members']]

  if (is.null(resp_df)) {

    expect_message(congress_data.member(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.member(resp))

  } else {

    expect_s3_class(
      congress_data.member(resp),
      "data.frame"
    )

  }

})



test_that("congress_data works for committee", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("committee", return.data = FALSE)

  resp_df <- resp[['content']][['committees']]

  if (is.null(resp_df)) {

    expect_message(congress_data.committee(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.committee(resp))

  } else {

    expect_s3_class(
      congress_data.committee(resp),
      "data.frame"
    )

  }

})



test_that("congress_data works for committee-report", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("committee-report", return.data = FALSE)

  resp_df <- resp[['content']][['reports']]

  if (is.null(resp_df)) {

    expect_message(congress_data.committeeReport(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.committeeReport(resp))

  } else {

    expect_s3_class(
      congress_data.committee_report(resp),
      "data.frame"
    )

  }

})



test_that("congress_data works for congressional-record", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("congressional-record", return.data = FALSE)

  resp_df <- resp[['content']][['Results']][['Issues']]

  if (is.null(resp_df)) {

    expect_message(congress_data.congressional_record(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.congressional_record(resp))

  } else {

    expect_s3_class(
      congress_data.congressional_record(resp),
      "data.frame"
    )

  }

})




test_that("congress_data works for house_communication", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("house-communication", return.data = FALSE)

  resp_df <- resp[['content']][['houseCommunications']]

  if (is.null(resp_df)) {

    expect_message(congress_data.house_communication(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.house_communication(resp))

  } else {

    expect_s3_class(
      congress_data.house_communication(resp),
      "data.frame"
    )

  }

})



test_that("congress_data works for nomination", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("nomination", return.data = FALSE)

  resp_df <- resp[['content']][['nominations']]

  if (is.null(resp_df)) {

    expect_message(congress_data.nomination(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.nomination(resp))

  } else {

    expect_s3_class(
      congress_data.nomination(resp),
      "data.frame"
    )

  }

})




test_that("congress_data works for treaty", {

  skip_on_cran()
  skip_if_key_missing()

  resp <- get_congress("treaty", return.data = FALSE)

  resp_df <- resp[['content']][['treaties']]

  if (is.null(resp_df)) {

    expect_message(congress_data.treaty(resp))

  } else if (length(resp_df) == 0) {

    expect_warning(congress_data.treaty(resp))

  } else {

    expect_s3_class(
      congress_data.treaty(resp),
      "data.frame"
    )

  }

})

test_that("NULL dataframe throws warning", {

  parsed <-
    structure(
      list(content =
        list(
          treaties = NULL
            )
        ),
    class = c("congress_api", "treaty")
  )

  expect_message(congress_data.treaty(parsed),
                 "Warning: endpoint cannot be coerced to dataframe")

})
