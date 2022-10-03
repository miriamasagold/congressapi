

# Helper functions

rename_nested <- function(.data, col) {

  data_no_col <-
    .data[, !names(.data) %in% col]

  col_unnested <- .data[[col]]

  names(col_unnested) <-
    paste0(col, "_", names(col_unnested))

  out <-
    cbind(
      data_no_col,
      col_unnested
    )

  return(out)

}

replace_empty <- function(x) {

  x[which(x == "")] <- NA

  return(x)

}

# Extracts and cleans dataframes from each endpoint

congress_data <- function(parsed) {

  UseMethod("congress_data")

}

# Methods for each endpoint's S3 class

congress_data.bill <- function(parsed) {

  bill_df <-
    parsed[['content']][['bills']]

  if (is.null(bill_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(bill_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
              parsed$path,
              call. = FALSE)

    return(parsed$content)

  } else {

    out <-
      rename_nested(
        .data = bill_df,
        col = "latestAction"
        )

    return(out)

  }

}
congress_data.amendment <- function(parsed) {

  amendment_df <-
    parsed[['content']][['amendments']]

  if (is.null(amendment_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(amendment_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

  out <-
    rename_nested(
      .data = amendment_df,
      col = "latestAction"
      )

  return(out)
  }

}
congress_data.summaries <- function(parsed) {

  summaries_df <-
    parsed[['content']][['summaries']]

  if (is.null(summaries_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(summaries_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

    out <-
      rename_nested(
        .data = summaries_df,
        col = "bill"
        )

    return(out)

  }

}
congress_data.congress <- function(parsed) {

  congress_df <-
    parsed[['content']][['congresses']]

  if (is.null(congress_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(congress_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)
  } else {

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
  }
congress_data.member <- function(parsed) {


  member_df <- parsed[['content']][['members']]

  if (is.null(member_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(member_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

    } else {

    member_no_depict_serve <-
      member_df[, !(names(member_df) %in% c("depiction", "served"))]

    member_served <- member_df$served

    chambers <- names(member_served)

    clean_serve <- function(chamber) {

      null_dates <- vapply(member_served[[chamber]], is.null,
                           FUN.VALUE = TRUE)

      member_served[[chamber]][null_dates] <- NA

      cl_s <- do.call(rbind, member_served[[chamber]])

      cl_s <- cl_s[, c(2,1)]

      names(cl_s) <- paste0(tolower(chamber), "_",
                           names(cl_s))

      return(cl_s)

    }

    cleaned_chambers <- lapply(chambers, clean_serve)

    member_served_clean <- do.call(cbind, cleaned_chambers)

    member_depiction <- member_df$depiction

    names(member_depiction) <-
      paste0("depiction_", names(member_depiction))

    out <- cbind(
      member_no_depict_serve,
      member_depiction,
      member_served_clean
    )

    return(out)

  }

}

congress_data.committee <- function(parsed) {

  # Extract dataframe from content
  cmte_df <- parsed[['content']][['committees']]

  if (is.null(cmte_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(cmte_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

    # remove 'parent$' prefixes from parent columns
    cmte_unnested <- rename_nested(cmte_df, "parent")

    # Remove subcommittees list column
    cmte_no_subcmte <-
      cmte_unnested[, !(names(cmte_unnested) %in% c("subcommittees"))]

    # extract subcommittee columns
    cmte_subcmte <- cmte_df[["subcommittees"]]

    # Find amount of repeated rows needed in original dataframe
    # to accomodate multiple subcommittees per committee
    rep_rows <- vapply(cmte_subcmte,
                       nrow,
                       FUN.VALUE = rep(length(cmte_subcmte)))

    rep_rows[which(rep_rows==0)] <- 1

    # Apply that row-repetition to the original committee dataframe
    cmte_expand <-
      lapply(cmte_no_subcmte,
             function(x) rep(x, rep_rows))

    cmte_expanded_df <- as.data.frame(cmte_expand)

    # Replace empty subcommittee entries with NA's so they aren't lost in binding
    cmte_subcmte[
      vapply(cmte_subcmte,
             function(x) nrow(x) %in% c(0, NULL),
             FUN.VALUE = FALSE)
      ] <- NA

    # Row-bind all subcommittee dataframes
    subcmte_unnested <-
      do.call(rbind, cmte_subcmte)

    # paste 'subcommittee' before subcommittee column names
    names(subcmte_unnested) <-
      paste0("subcommittee_", names(subcmte_unnested))

    # Column-bind unnested subcommittees to original expanded dataframe
    out <-
      cbind(
        cmte_expanded_df,
        subcmte_unnested,
        row.names = NULL
        )

    return(out)

  }

}
congress_data.committeeReport <- function(parsed) {

  cmteRep_df <- parsed[['content']][['reports']]

  if (is.null(cmteRep_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(cmteRep_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

    return(cmteRep_df)

  }
}
congress_data.congressional_record <- function(parsed) {

  cr_df <- parsed[['content']][['Results']][['Issues']]

  if (is.null(cr_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(cr_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

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

    out <- cbind(cr_no_links, links_binded)

    return(out)

  }

}
congress_data.house_communication <- function(parsed) {

  hs_comm_df <- parsed[['content']][['houseCommunications']]

  if (is.null(hs_comm_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(hs_comm_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

    out <-
      rename_nested(
        .data = hs_comm_df,
        col = "communicationType"
        )

    return(out)

  }
}

congress_data.nomination <- function(parsed) {

  nom_df <-
    parsed[['content']][['nominations']]

  if (is.null(nom_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

  } else if (length(nom_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

  } else {

    nom_nomType <-
      rename_nested(
        nom_df,
        "nominationType"
      )

    nom_latestAction <-
      nom_df[['latestAction']]

    latestAction <-
      do.call(rbind,
              nom_latestAction)

    nom_nomType[['latestAction']] <-
      latestAction

    out <-
      rename_nested(
        nom_nomType,
        "latestAction"
      )

    return(out)

  }

}
congress_data.treaty <- function(parsed) {

  treaty_df <-
    parsed[['content']][['treaties']]

  if (is.null(treaty_df)) {

    message("Warning: endpoint cannot be coerced to dataframe\n")

    return(parsed$content)

    } else if (length(treaty_df) == 0) {

    warning("No content was returned.\nYour API call was: ",
            parsed$path,
            call. = FALSE)

    return(parsed$content)

    } else {

    parts_empty <-
      min(
        dim(
          treaty_df[['parts']]
          ),
        na.rm = TRUE
      )

    if (parts_empty == 0) {

      treaty_df[['parts']] <- rep(NA, nrow(treaty_df))

    }

   out <-
     as.data.frame(
      lapply(
        treaty_df,
        replace_empty
      )
    )

    return(out)

  }

}


