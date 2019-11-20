# visualizeCommunities.R

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
  graphics::plot(communities, graph, mark.col=colCom, mark.border="white", layout=layout)
  graphics::legend("topleft", legend=communitiesList, fill=colCom, title="Modules", box.col="white")
  return(0)
}



