# getAllPossibleGroups.R

source("./R/getModuleNames.R")

#' Makes df containing all possible combined modules of length 2 with density calculated
#'
#' @param graph a valid graph object
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @param moduleGraphs df with $MODULE module name, $SUBGRAPH graph for verts in module, $DENSITY density of subgraph
#' @return df like moduleGraphs, where each module is every possible module combination of size 2
getAllPossibleGroups <- function(graph, vert, moduleGraphs) {
  numModules <- length(unique(moduleGraphs$MODULE))
  # adapted from: https://www.mathsisfun.com/combinatorics/combinations-permutations-calculator.html
  numChosen <- factorial(numModules) / (factorial(2) * factorial(numModules - 2)) # Probability theory
  # Initialize lists to fill df
  moduleList <- list()
  subgraphList <- list()
  subdensityList <- list()
  i = 1
  count = 1
  while (i <= numModules) {
    j = i + 1
    mod1 <- moduleGraphs$MODULE[[i]]
    while (j <= numModules) {
      mod2 <- moduleGraphs$MODULE[[j]]
      mods <- paste0(mod1, " ", mod2)
      moduleList <- append(moduleList, mods)
      vertInMod <- vert[vert$MODULE %in% getModuleNames(mods), ]
      combinedGraph <- igraph::induced_subgraph(graph, vertInMod$GENE)
      subgraphList <- append(subgraphList, list(combinedGraph))
      subdensityList <- append(subdensityList, edge_density(combinedGraph))
      j = j + 1
      count = count + 1
    }
    i = i + 1
  }
  # Initialize DF
  grouped <- data.frame(matrix(data = c(moduleList, subgraphList, subdensityList), nrow = numChosen, ncol = 3))
  colnames(grouped) <- c("MODULE", "SUBGRAPH", "DENSITY")
  return(grouped)
}
