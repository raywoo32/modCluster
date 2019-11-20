# visualizeGraph.R

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



