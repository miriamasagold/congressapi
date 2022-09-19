
groups <-
  c(bill = "bill", amendment = "amendment",
    summaries = "summaries", congress = "congress",
    member = "member", committee = "committee",
    committeeReport = "committeeReport",
    `congressional-record` = "congressional-record",
    `house-communication` = "house-communication",
    nomination = "nomination", treaty = "treaty")

all_group_resp <-
  purrr::map(.x = groups, .f = congressGet, group_args = "")


all_group_parsed <-
  purrr::map(all_group_resp, congressParse)


purrr::map(all_group_parsed, class)




congressData <- function(parsed) {

  UseMethod("congressData")

}

congressData.bill <- function(parsed) {

  bill_df <- parsed[['content']][['bills']]

  bill_no_latest_action <-
    bill_df[, !(names(bill_df) %in% "latestAction")]

  latest_action_unnested <- bill_df$latestAction

  out <-
    cbind(bill_no_latest_action,
          latest_action_unnested)

  return(out)
}

congressData.amendment <- function(parsed) {

  amendment_df <- parsed[['content']][['amendments']]

  amendment_no_latest_action <-
    amendment_df[, !(names(amendment_df) %in% "latestAction")]

  latest_action_unnested <- amendment_df$latestAction

  out <-
    cbind(amendment_no_latest_action,
          latest_action_unnested)

  return(out)

}
congressData.summaries <- function(parsed) {

  summaries_df <- parsed[['content']][['summaries']]

  summaries_no_bill <-
    summaries_df[, !names(summaries_df) %in% "bill"]

  bill_unnested <- summaries_df$bill

  names(bill_unnested) <-
    paste0("bill_", names(bill_unnested))

  out <-
    cbind(summaries_no_bill,
          bill_unnested)

  return(out)

}
congressData.congress <- function(parsed) {

  congress_df <-
    parsed[['content']][['congresses']]

  congress_sessions <- congress_df[['sessions']]

  rep_rows <- vapply(congress_sessions,
                     nrow,
                     FUN.VALUE = rep(length(congress_sessions)))

  congress_no_sessions <-
    congress_df[, !(names(congress_df) %in% "sessions")]

  congress_expanded <-
    lapply(congress_no_sessions,
           function(x) rep(x, rep_rows))

  congress_expanded_df <- as.data.frame(congress_expanded)

  sessions_unnested <-
    do.call(rbind, congress_sessions)

  out <-
    cbind(
      congress_expanded_df,
      sessions_unnested
    )

  return(out)

  }

congressData.member <- function(parsed) {

}
congressData.committee <- function(parsed) {

}
congressData.committeeReport <- function(parsed) {

}

congressData.congressional_record <- function(parsed) {

  cr_df <- parsed[['content']][['Results']][['Issues']]

  cr_links <- cr_df$Links

  links_cols <- names(cr_links)

  unnest_links <- function(i) {

    cr_links_i <- cr_links[[links_cols[i]]]

    pdf <- cr_links_i[['PDF']]

    pdf_link_col <- vector(length = length(pdf))

    for (j in seq_along(pdf)) {

      if (is.null(pdf[[j]][[2]])) {

        pdf_link_col[j] <- NA_character_

      } else {

        pdf_link_col[j] <- pdf[[j]][[2]]

      }

    }

    new_pdf_links <-
      data.frame(
        PDF = pdf_link_col
      )

    compile_links <- cbind(cr_links_i[,-3],
                           new_pdf_links)

    col_prefix <- tolower(links_cols[[i]])

    names(compile_links) <-
      paste0(col_prefix, "_",
             tolower(names(compile_links)))

    return(compile_links)

  }

  links_unnested <-
    lapply(seq_along(links_cols), unnest_links)

  links_binded <- do.call(cbind, links_unnested)

  cr_no_links <-
    cr_df[, !(names(cr_df) %in% "Links")]

  cr_out <- cbind(cr_no_links, links_binded)

  return(cr_out)

}

congressData.house_communication <- function(parsed) {

}
congressData.nomination <- function(parsed) {

}
congressData.treaty <- function(parsed) {

}


