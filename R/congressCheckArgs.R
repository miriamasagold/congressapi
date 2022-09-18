congressCheckArgs(a = NULL, b = "2", c = NULL)


congressCheckArgs <- function(...) {

  args <- list(...)

  which_args_null <- lapply(args,
                            function(x) !is.null(x))

  iter_length <- length(which_args_null)-1

  res <- vector(length = iter_length)

  for (i in seq_len(iter_length)) {

    res[[i]] <- which_args_null[[i]] >= which_args_null[[i+1]]

  }

  if (sum(res) < iter_length) {

    stop("Later endpoint arguments may not be specified before proceeding ones.")

  }

}

