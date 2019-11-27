# runExample.R

# TODO: DOCUMENT
#' @export
#' @import shiny
runExample <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "modCluster")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `modCluster`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
