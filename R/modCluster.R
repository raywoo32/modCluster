# modCluster.R


#' Controller function available to the user to display
#'
#' @param edges valid edges as described by igraph::graph_from_data_frame
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @param displayGene a flag to choose to display or hide genes
#' @return NULL
#' @export
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
  }
  else {
    visualizeGraph(graph, chosen, layout, membership, communitiesList)
  }
}

#load("./inst/exampleEdge.Rda")
#load("./inst/exampleVert.Rda")
#modCluster(edges, vert)
#modCluster(edges, vert, displayGene=TRUE)
