

## Generic query function


congress_query <- function(group, ...) {
  
  if (length(group) != 1) stop("group must be length 1")
  
  if (!(group %in%
        c("bill",
          "amendment",
          "summaries",
          "congress",
          "member",
          "committee",
          "committeeReport",
          "congressional-record",
          "house-communication",
          "nomination",
          "treaty"))) {
    
    stop("invalid group name. Must be one of bill, amendment, summaries, congress, member, committee, committeeReport, congressional-record, house-communication, nomination, treaty")
  
    }
  
  
  
  f <- switch (group,
               "bill" = congress_bill,
               "amendment" = congress_amendment,
               "summaries" = congress_summaries,
               "congress" = congress_congress,
               "member" = congress_member,
               "committee" = congress_committee,
               "committeeReport" = congress_committeeReport,
               "congressional-record" = congress_congressional_record,
               "house-communication" = congress_house_communication,
               "nomination" = congress_nomination,
               "treaty" = congress_treaty
  )
  
  resp <- f(...)
  
  
  raw <- congressParse(resp)
  
  return(raw)
  
  
}









