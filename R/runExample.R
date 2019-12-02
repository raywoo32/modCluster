# runExample.R

#' Run shiny app that shows and visualizes example
#'
#' @export
#' @import shiny
#' @example
#'\dontrun{
#' modCluster::runExample()
#'}
runExample <- function() {
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  appDir <- system.file("shiny-examples", "myapp", package = "modCluster")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `modCluster`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
