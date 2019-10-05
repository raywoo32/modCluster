# makeModuleGraphs.R

#' Make df with module name, subgraph and density
#'
#' @param edges valid edges as described by igraph::graph_from_data_frame
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @return df with columns (MODULES, SUBGRAPHS, DENSITY) from modules in verts
makeModuleGraphs <- function(edges, vert) {
  graph <- igraph::graph_from_data_frame(edges, directed = FALSE, vertices = vert)
  uniModules <- unique(vert[,"MODULE"])
  subgraphList <- list()
  subDensityList <- list()
  # get subgraph and density
  for (module in uniModules) {
    i <- which(vert$MODULE == module)
    # adapted from: https://stackoverflow.com/questions/32507042/return-data-frame-values-with-list-of-indices
    vertInMod <- vert[i, 1]
    subgraph <- igraph::induced_subgraph(graph, vertInMod)
    subgraphList <- append(subgraphList, list(subgraph))
    if (is.null(edges$WEIGHT)) { #Use igraph density
      subDensity <-  igraph::edge_density(subgraph, loops = FALSE)
    }
    else { #Use own weighted density
      subDensity <- edge_density(subgraph)
    }
    subDensityList <- append(subDensityList, subDensity)
  }
  subgraphDF <- data.frame(matrix(data = c(uniModules, subgraphList, subDensityList), nrow = length(uniModules), ncol = 3))
  colnames(subgraphDF) <- c("MODULE", "SUBGRAPH", "DENSITY")
  return(subgraphDF)
}
