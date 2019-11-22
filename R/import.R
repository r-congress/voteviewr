
#' Read Voteview data
#'
#' Returns data frame of data provided by Voteview.com
#'
#' @param chamber Specify which chamber of Congress–default is "both"
#' @param congress Specify which number of Congress. The default is the current
#'   Congress.
#' @param year Optionally instead of specifying congress you may specify a year
#'   or Date and the congress number will be inferred
#' @return A tibble of voteview information
#' @export
read_voteview <- function(chamber = c("both", "house", "senate"), congress = NULL, year = NULL) {
  hs <- switch(match.arg(chamber), house = "H", senate = "S", both = "HS")
  if (is.null(congress) && !is.null(year)) {
    congress <- which_congress(year)
  }
  if (is.null(congress)) {
    congress <- which_congress()
  }
  suppressMessages(
    readr::read_csv(
      paste0("https://voteview.com/static/data/out/members/",
        hs, congress, "_members.csv")
    )
  )
}


which_congress <- function(date = NULL) {
  if (is.null(date)) {
    date <- format(Sys.Date(), "%Y")
  }
  if (grepl("^\\d{4}$", date)) {
    date <- paste0(date, "-05-31")
  }
  if (!inherits(date, "Date")) {
    date <- as.Date(date)
  }
  with(congress_numbers, congress[which(date >= begin & date <= end)])
}



#readr::read_csv("https://voteview.com/static/data/out/members/HS116_members.csv")
