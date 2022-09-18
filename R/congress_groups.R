
#===============================================================================
# GROUP-specific request functions
#===============================================================================
## ==========
## bill
## ==========
congress_bill <-
  function(
    congress = NULL,
    billType = NULL,
    billNumber = NULL,
    bill_option = NULL,
    ...
    ) {

  # Combine group args
  group_vec <-
    c(congress,
      billType,
      billNumber,
      bill_option
    )

  if (length(group_vec) < 4 & !is.null(bill_option)) {
    stop("bill_options cannot be specified if any congress, billType, and billNumber are NULL")
  }

  if (!is.null(bill_options) & length(bill_option) != 1) {
    stop("bill_options must be length 1")
  }

  group_args <- paste0(group_vec, collapse = "/")


  req <- congressGet(group = "bill",
                     group_args = group_args,
                     ...)

  return(req)

  }

## ==========
## amendment
## ==========

congress_amendment <-
  function(
    congress = NULL,
    amendmentType = NULL,
    amendmentNumber = NULL,
    amendment_option = NULL,
    ...
    ) {

    # Combine group args
    group_vec <-
      c(congress,
        amendmentType,
        amendmentNumber,
        amendment_option
      )

    if (length(group_vec) < 4 & !is.null(amendment_option)) {
      stop("amendment_option cannot be specified if any congress, amendmentType, and amendmentNumber are NULL")
    }

    if (!is.null(bill_options) & length(bill_options) != 1) {
      stop("amendment_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "amendment",
                       group_args = group_args,
                       ...)

    return(req)

  }

## summaries

congress_summaries <-
  function(
    congress = NULL,
    billType = NULL,
    ...
    ) {

    # Combine group args
    group_vec <-
      c(congress,
        billType
      )

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "summaries",
                       group_args = group_args,
                       ...)

    return(req)


  }

## congress
congress_congress <-
  function(
    congress = NULL,
    ...
    ) {

    req <- congressGet(group = "congress",
                       group_args = congress,
                       ...)

    return(req)

  }
## member
congress_member <-
  function(
    bioguideId = NULL,
    member_option = NULL,
    ...
    ) {
    # Combine group args
    group_vec <-
      c(bioguideId,
        member_option
        )

    if (length(group_vec) < 2 & !is.null(member_option)) {
      stop("member_option cannot be specified if member is NULL")
    }

    if (!is.null(member_option) & length(member_option) != 1) {
      stop("member_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "member",
                       group_args = group_args,
                       ...)

    return(req)

  }
## committee
congress_committee <-
  function(
    chamber = NULL,
    committeeCode = NULL,
    committee_option = NULL,
    ...
    ) {

    # Combine group args
    group_vec <-
      c(chamber,
        committeeCode,
        committee_option
      )

    if (length(group_vec) < 3 & !is.null(committee_option)) {
      stop("committee_option cannot be specified if chamber or committeeCode is NULL")
    }

    if (!is.null(committee_option) & length(committee_option) != 1) {
      stop("committee_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "committee",
                       group_args = group_args,
                       ...)

    return(req)

  }

## committeeReport
congress_committeeReport <-
  function(
    congress = NULL,
    reportType = NULL,
    reportNumber = NULL,
    report_option = NULL,
    ...
    ) {

    # Combine group args
    group_vec <-
      c(congress,
        reportType,
        reportNumber,
        report_option
      )

    if (length(group_vec) < 3 & !is.null(report_option)) {
      stop("report_option cannot be specified if any congress, reportType, or reportNumber are NULL")
    }

    if (!is.null(report_option) & length(report_option) != 1) {
      stop("report_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "committeeReport",
                       group_args = group_args,
                       ...)

    return(req)
  }

## congressional-record
congress_congressional_record <-
  function(
    ...
    ) {

    req <- congressGet(group = "congressional-record",
                       group_args = NULL,
                       ...)

    return(req)

  }

## house-communication
congress_house_communication <-
  function(
    congress = NULL,
    communicationType = NULL,
    communicationNumber = NULL,
    ...
    ) {

    group_vec <-
      c(congress,
        communicationType,
        communicationNumber
      )

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "house-communication",
                       group_args = group_args,
                       ...)

    return(req)

  }

## nomination
congress_nomination <-
  function(
    congress = NULL,
    nominationNumber = NULL,
    nomination_option = NULL,
    ...
    ) {
    # Combine group args
    group_vec <-
      c(congress,
        nominationNumber,
        nomination_option
      )

    if (length(group_vec) < 3 & !is.null(nomination_option)) {
      stop("nomination_option cannot be specified if any congress, nominationNumber, or nomination_option are NULL")
    }

    if (!is.null(nomination_option) & length(nomination_option) != 1) {
      stop("nomination_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "nomination",
                       group_args = group_args,
                       ...)

    return(req)

  }
## treaty
congress_treaty <-
  function(
    congress = NULL,
    treatyNumber = NULL,
    treatySuffix = NULL,
    treaty_option = NULL,
    ...
    ) {

    # Combine group args
    group_vec <-
      c(congress,
        treatyNumber,
        treatySuffix,
        treaty_option
      )

    if (is.null(treatyNumber) & is.null(treatySuffix) & !is.null(treaty_option)) {
      stop("treaty_option cannot be specified if both treatyNumber and treatySuffix are NULL")
    }

    if (!is.null(treaty_option) & length(treaty_option) != 1) {
      stop("treaty_option must be length 1")
    }

    group_args <- paste0(group_vec, collapse = "/")


    req <- congressGet(group = "treaty",
                       group_args = group_args,
                       ...)

    return(req)

  }

