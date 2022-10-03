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
    replace_empty(x = dat),
    c(NA, "x", 1)
  )

})
