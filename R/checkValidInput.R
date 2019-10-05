# checkValidInput.R

#' Checks if input is valid. If valid returns igraph object as described by igraph::isgraph
#'
#' @param edges valid edges as described by igraph::graph_from_data_frame
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @return graphOject when valid, error when invalid
# adapted from: https://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r
checkValidInput <- function(edges, vert) {
  tryCatch(
    {
      if(is.null(vert$MODULE[[1]])) {
        stop("There is no module attribute on vertex object")
      }
      graph <- igraph::graph_from_data_frame(edges, directed = FALSE, vertices = vert)
      # TODO: check for weight attribute, check for verticies to have at least on factor
    },
    error=function(cond) {
      message("The edges and vert are not in the correct format")
      message("Here's the original error message:")
      message(cond)
      return(NA)
    }
  )
}
