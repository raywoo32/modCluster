# modCluster.R

#' Controller function available to the user to display
#'
#' @param edges valid edges as described by igraph::graph_from_data_frame
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @param displayGene a flag to choose to display or hide genes
#' @return NULL
#' @export
#'
#'
#'@examples
#'\dontrun{
#' load("./inst/exampleEdge.Rda")
#' load("./inst/exampleVert.Rda")
#' modCluster(edges, vert) // display gene is auto false
#' modCluster(edges, vert, displayGene=TRUE)
#'}
modCluster <- function(edges, vert, displayGene=FALSE) {
  graph <- checkValidInput(edges, vert)
  moduleGraphs <- makeModuleGraphs(edges, vert)
  grouped <- getAllPossibleGroups(graph, vert, moduleGraphs)
  sorted <- makeSortedCompare(moduleGraphs, grouped)
  bestGroups <- chooseBestGroups(sorted, 1)
  chosen <- getChosenMods(bestGroups, moduleGraphs, grouped)
  layout <- makeLayout(chosen)
  communitiesOutput <- makeCommunities(graph, chosen)
  communities <- communitiesOutput$communities
  communitiesList <- communitiesOutput$legend
  membership <- communitiesOutput$membership
  if (displayGene == FALSE) {
    visualizeCommunities(graph, chosen, layout, membership, communities, communitiesList)
    return("no_display_gene")
  }
  else {
    visualizeGraph(graph, chosen, layout, membership, communitiesList)
    return("display_gene")
  }
}


#' Checks if input to modCluster is valid. If valid returns igraph object as
#' described by igraph::isgraph
#'
#' @param edges valid edges as described by igraph::graph_from_data_frame
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @return graphOject when valid, error when invalid
#' @import igraph
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



