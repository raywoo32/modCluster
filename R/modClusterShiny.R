# modClusterShiny.R

#' Run shiny app that shows and visualizes example
#'
#' @export
#' @import shiny
#' @examples
#'\dontrun{
#' modCluster::runExample()
#'}
modClusterShiny <- function() {
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  appDir <- system.file("shiny-examples", "myapp", package = "modCluster")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `modCluster`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
