# chooseGroups.R

#' Helper function to modCluster
#' Combines df with modules and combined modules and sorts in descending
#'
#' @param ungrouped df with $MODULE ungrouped module name $SUBGRAPH igraph object $DENSITY density of subgraph
#' @param grouped  df with $MODULE grouped module name $SUBGRAPH igraph object $DENSITY density of subgraph
#' @return sorted df
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

