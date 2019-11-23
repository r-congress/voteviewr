
#' Read Voteview data
#'
#' Returns data frame of data provided by Voteview.com
#'
#' @param chamber Specify which chamber of Congress–default is "both"
#' @param congress Specify which number of Congress. The default is the current
#'   Congress.
#' @param year Optionally instead of specifying congress you may specify a year
#'   or Date and the congress number will be inferred
#' @param quiet Logical indicating whether to silence column parsing messages
#' @return A tibble of voteview information
#' @export
read_voteview <- function(chamber = c("both", "house", "senate"),
                          congress = NULL,
                          year = NULL,
                          quiet = TRUE) {
  UseMethod("read_voteview")
}



#' @export
read_voteview.character <- function(chamber = c("both", "house", "senate"),
                                    congress = NULL,
                                    year = NULL,
                                    quiet = TRUE) {
  if (grepl("(^\\d{1,}\\w{0,3}$)|(^\\d+$)", chamber)) {
    chamber <- as.integer(sub("\\w+", "", chamber))
    return(read_voteview(chamber, congress, year, quiet))
  }
  read_voteview(as_chamber(chamber), congress, year, quiet)
}

#' @export
read_voteview.numeric <- function(chamber = c("both", "house", "senate"),
                                  congress = NULL,
                                  year = NULL,
                                  quiet = TRUE) {
  read_voteview(as.integer(chamber), congress, year, quiet)
}

#' @export
read_voteview.integer <- function(chamber = c("both", "house", "senate"),
                                  congress = NULL,
                                  year = NULL,
                                  quiet = TRUE) {
  if (chamber > 1000) {
    year <- as_year(chamber)
    chamber <- if (is.character(year)) year else NULL
  } else {
    congress <- as_congress(chamber)
    chamber <- if (is.character(congress)) congress else NULL
  }
  read_voteview(chamber, congress, year, quiet)
}

#' @export
read_voteview.default <- function(chamber = c("both", "house", "senate"),
                                  congress = NULL,
                                  year = NULL,
                                  quiet = TRUE) {
  hs <- as_chamber(chamber)
  if (is.null(congress) && !is.null(year)) {
    congress <- which_congress(year)
  }
  if (is.null(congress)) {
    congress <- which_congress()
  }
  utils::download.file(paste0("https://voteview.com/static/data/out/members/",
    hs, as_congressf(congress), "_members.csv"),
    tmp <- tempfile(), quiet = TRUE)
  x <- silence(quiet, readr::read_csv(tmp))
  if (is.recursive(x) && NROW(x) > 0L) {
    x[[".timestamp"]] <- Sys.time()
  }
  x
}

silence <- function(quiet = TRUE, ...) {
  if (quiet) {
    suppressMessages(...)
  } else {
    eval(...)
  }
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
