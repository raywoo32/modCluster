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
      if(length(NULL %in% edges$WEIGHT) != 0 || length(edges$WEIGHT) == 0) { #bad edges
        stop("There are no edge weights")
      }
      graph <- igraph::graph_from_data_frame(edges, directed = FALSE, vertices = vert)
      # TODO: check for weight attribute, check for verticies to have at least on factor
      error=function(cond) {
        message("The edges and vert are not in the correct format")
        message("Here's the original error message:")
        message(cond)
        return(NA)
      }
      return(graph)
  })
}


#' Visualizes graph communities
#'
#' @param graph a valid igraph object
#' @param chosen df with chosen grouped modules
#' @param layout xy layout object
#' @param membership list of gene names and module name
#' @param communities igraph communities object
#' @param communitiesList list of modules
#' @import igraph graphics grDevices
#' @return 0
visualizeCommunities <- function(graph, chosen, layout, membership, communities, communitiesList) {
  # Adapted From: https://stackoverflow.com/questions/24595716/assign-colors-to-communities-in-igraph
  colCom <- grDevices::hcl.colors(max(membership)+1, palette = "Set 3", alpha = 0.2, rev = FALSE, fixup = TRUE)
  graphics::par(mar=c(1,1,1,1))
  colVer <- grDevices::hcl.colors(max(membership)+1, palette = "Set 3", rev = FALSE, fixup = TRUE)
  V(graph)$color <- colVer[membership + 1]
  graphics::plot(communities, graph, color=colVer[membership], mark.col=colCom, mark.border="white", layout=layout)
  graphics::legend("topleft", legend=communitiesList, fill=colCom, title="Modules", box.col="white")
  return(0)
}


#' Visualizes graph with gene names
#'
#' @param graph a valid igraph object
#' @param chosen df with chosen grouped modules
#' @param layout xy layout object
#' @param membership list of gene names and module name
#' @param communitiesList list of modules
#' @import igraph graphics grDevices
#' @return 0
visualizeGraph <- function(graph, chosen, layout, membership, communitiesList) {
  # Adapted from: https://stackoverflow.com/questions/24595716/assign-colors-to-communities-in-igraph
  # Adapted from: http://www.sthda.com/english/wiki/add-legends-to-plots-in-r-software-the-easiest-way
  colG <- grDevices::hcl.colors(max(membership)+1, palette = "Set 3", alpha = NULL, rev = FALSE, fixup = TRUE)
  igraph::V(graph)$label.color <- colG[membership]
  igraph::V(graph)$label.cex = 0.7
  graphics::par(mar=c(1,1,1,1))
  igraph::plot.igraph(graph, layout=layout,  vertex.size=0.3, vertex.label = igraph::V(graph)$name, edge.color="grey",  vertex.label.dist=1.5)
  graphics::legend("topleft", legend=communitiesList, fill=colG, title="Modules", box.col="white")
  return(0)
}


