# makeCommunities.R

#' Change igraph object properties (communities, membership) a list of combined modules
#'
#' @param graph a valid igraph object
#' @param chosen df with chosen combined modules (columns $MODULE, $SUBGRAPH, $DENSITY)
#' @import igraph
#' @return list containing communities, communities list, and igraph membership
makeCommunities <- function(graph, chosen) {
  # Change from default membership
  membership <- igraph::components(graph)$membership
  communitiesList <- list()
  # adapted from: https://stackoverflow.com/questions/24595716/assign-colors-to-communities-in-igraph
  for (i in 1:nrow(chosen)) {
    vertexInMod <- igraph::V(chosen$SUBGRAPH[[i]])$name
    community <- chosen$MODULE[[i]]
    communitiesList <- append(communitiesList, community)
    for (j in 1:length(vertexInMod)) {
      vertex <- vertexInMod[[j]]
      membership[vertex] <- i #arbitrarily numeric for rules of communities
    }
  }
  communities <- igraph::make_clusters(graph, membership = membership, algorithm = "modCluster", merges = NULL, modularity = FALSE)
  # Adapted from: https://stackoverflow.com/questions/8936099/returning-multiple-objects-in-an-r-function
   return(list( "communities" = communities, "legend" = communitiesList, "membership" = membership))
}



