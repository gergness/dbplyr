#' Explain sql
#' 
#' Any queries run inside this function will automatically be explained:
#' displaying information about which indexes are used to optimise the query.
#' This requires a little bit of knowledge about how \code{EXPLAIN} works for
#' your database, but is very useful for diagnosing performance problems.
#' 
#' @param code code to run. All sql queries executed during the running of the
#'   code will be shown and explained.
#' @param tbl an sql based table to explain.
#' @export
#' @examples
#' batting <- tbl(lahman(), "Batting")
#' 
#' # Note that you have to do something that actually triggers a query
#' # inside the explain function
#' explain_sql(batting)
#' explain_sql(head(batting))
#' # This has to run two queries because nrow is the same as dim(x)[1]
#' explain_sql(nrow(batting))
#' 
#' # If you just want to understand the sql for a tbl, use explain_tbl
#' explain_tbl(batting)
#' 
#' # The batting database has indices on all ID variables:
#' # SQLite automatically picks the most restrictive index
#' explain_tbl(filter(batting, lgID == "NL" && yearID == 2000))
#' 
#' # OR's will use multiple indexes
#' explain_tbl(filter(batting, lgID == "NL" || yearID == 2000))
explain_sql <- function(code) {
  old <- options(dplyr.explain_sql = TRUE, dplyr.show_sql = TRUE)
  on.exit(options(old))
  
  code
}

#' @export
#' @rdname explain_sql
explain_tbl <- function(tbl) {
  force(tbl)
  explain_sql(head(tbl))
  invisible(NULL)
}