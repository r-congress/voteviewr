## code to prepare `congress_numbers` dataset goes here
library(lop)
g <- hread("https://en.wikipedia.org/wiki/List_of_United_States_Congresses#111th_through_115th")
d <- htable(g, fill = TRUE, trim = TRUE)
d <- d[vap_lgl(d, ~ all(c("Congress", "Session dates") %in% names(.x)))]
d %>%
  lap(as_tbl) %>%
  brows() %>%
  janitor::clean_names() %>%
  mut(congress_began = ifelse(is.na(congress_began), congress_to_begin, congress_began),
    congress_began = ifelse(is.na(congress_began), congress_begins, congress_began),
    congress_began = as.Date(congress_began, format = "%B %d, %Y"),
    congress_ended = ifelse(is.na(congress_ended), congress_to_end, congress_ended),
    congress_ended = ifelse(is.na(congress_ended), congress_ends, congress_ended),
    congress_ended = as.Date(congress_ended, format = "%B %d, %Y"),
    #session = as.integer(tfse::regmatches_first(session, "\\d+")),
    congress = as.integer(tfse::regmatches_first(congress, "\\d+"))) %>%
  sel(congress, session, begin = congress_began, end = congress_ended) %>%
  gby(congress) %>%
  sms(begin = begin[1],
    end = end[length(end)]) ->
  congress_numbers
usethis::use_data(congress_numbers, overwrite = TRUE, internal = TRUE)
