as_congress <- function(x) {
  as.integer(gsub("\\D", "", x))
}
as_congressf <- function(x) {
  sprintf("%03d", as_congress(x))
}

as_year <- function(x) {
  as.integer(gsub("\\D", "", x))
}
set_class <- function(...) `class<-`(...)
as_chamber <- function(x) {
  if (length(x) == 0 || is.na(x[1])) {
    x <- "both"
  }
  if (is.recursive(x)) {
    stop("expected chamber to be 'both', 'house', or 'senate'", call. = FALSE)
  }
  x <- tolower(as.character(x[1]))
  if (!isTRUE(x %in% c("both", "house", "senate", "b", "h", "s", "hs"))) {
    x <- "both"
  }
  x <- switch(x,
    house = "H", senate = "S", both = "HS",
    h = "H", s = "S", b = "HS", hs = "HS", sh = "HS")
  set_class(x, "_chamber_")
}

