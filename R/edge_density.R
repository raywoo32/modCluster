
#' Modified igraph::edge_density to include weights
#'
#' @param graph a valid igraph object
#' @import igraph
#' @return float representing density of the graph
edge_density <- function(graph) {
  edges <- igraph::as_data_frame(graph)
  if (is.null(edges$WEIGHT)) {
    return(igraph::edge_density(graph)) #if unweighted call regular igraph edge_density
  }
  nvert <- length(igraph::V(graph))
  max_edges <- nvert*(nvert - 1) #from graph theory
  weight_sum <- 0
  if (nrow(edges) == 0) {
    return(0)
  }
  for (i in 1:nrow(edges)) {
    weight_sum <- weight_sum + as.numeric(edges$WEIGHT[[i]])
  }
  return(weight_sum/max_edges)
}



### Citations:
# About weighted density:
# [1] https://www.quora.com/How-do-you-compute-the-density-of-a-weighted-graph
# [2] Tokuyama, Takeshi, ed. Algorithms and Computation: 18th International Symposium, ISAAC 2007, Sendai, Japan, December 17-19, 2007, Proceedings. Vol. 4835. Springer, 2008.
# Inspired from:
# https://igraph.org/r/doc/edge_density.html

