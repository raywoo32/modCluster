# group.R


# getAllPossibleGroups.R

#' Makes df containing all possible combined modules of length 2 with density calculated
#'
#' @param graph a valid graph object
#' @param vert valid verticies as described by igraph::graph_from_data_frame
#' @param moduleGraphs df with $MODULE module name, $SUBGRAPH graph for verts in module, $DENSITY density of subgraph
#' @import igraph
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


#' Helper function to modCluster
#' Combines df with modules and combined modules and sorts in descending
#'
#' @param ungrouped df with $MODULE ungrouped module name $SUBGRAPH igraph object $DENSITY density of subgraph
#' @param grouped  df with $MODULE grouped module name $SUBGRAPH igraph object $DENSITY density of subgraph
#' @return sorted df
#' @import igraph
makeSortedCompare <- function(ungrouped, grouped) {
  # Make combined sorted list
  # Adapted From: https://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame/18143097
  # Adapted From: https://stackoverflow.com/questions/10085806/extracting-specific-columns-from-a-data-frame
  toCompare <- rbind(grouped[, c(1, 3)], ungrouped[, c(1, 3)])
  toCompare[is.na(toCompare)] <- 0
  toCompare <- as.data.frame(lapply(toCompare, unlist))
  toCompare <- toCompare[order(- toCompare$DENSITY),]
  return(toCompare)
}

#' Selects best groups by highest density metrics
#'
#' @param sorted sorted output of makeSortedCompare
#' @param minModSize int size of the smallest module
#' @return string list of best groups in sorted
chooseBestGroups <- function(sorted, minModSize) {
  taken <- list()
  groups <- list()
  for (i in 1:nrow(sorted)) {
    mods <- getModuleNames(as.character(sorted$MODULE[i]))
    if (length(mods) > minModSize) { #if the length is bigger than min size check if alone mods are better else add to list
      isBest = TRUE
      for (j in (i-1):1) {
        if (j == 0) {
          break #first therefore best group in sorted list
        }
        betterMods <- getModuleNames(as.character(sorted$MODULE[j]))
        # check if better module already used
        if ((TRUE %in% (betterMods %in% taken))) {
          next
        }
        inMods <- mods %in% betterMods
        if (TRUE %in% inMods) { #check if module above is in a lower module
          isBest = FALSE
        }
      }
    }
    if (isBest == TRUE && !(TRUE %in% (mods %in% taken))) {
      taken <- append(taken, mods)
      groups <- append(groups, paste(mods, collapse=' ' ))
    }
  }
  return(groups)
}


#' Helper function that converts modules from string to vector
#'
#' @param mods string representing modules
#' @return vector of modules
getModuleNames <- function(mods) {
  split<- (strsplit(mods, " "))[[1]]
  return(split)
}


