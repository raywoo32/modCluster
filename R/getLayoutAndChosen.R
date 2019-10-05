# getLayoutAndChosen.R

#' Get df with module name, subgraph and density for the groups with the best density
#'
#' @param bestGroups strings of best combined module groups
#' @param moduleGraphs df with $MODULE, $SUBGRAPH, $DENSITY for provided modules
#' @param grouped df with $MODULE, $SUBGRAPH, $DENSITY for all grouped modules
#' @return df with $MODULE, $SUBGRAPH, $DENSITY for the modules in bestGroups
getChosenMods <- function(bestGroups, moduleGraphs, grouped) {
  selectFrom <- rbind(grouped, moduleGraphs)
  selected <- selectFrom[0,] #make empty frame with same columns
  for (i in 1:length(bestGroups)) { #populate frame
    group <- bestGroups[[i]]
    groupRow <- selectFrom[selectFrom$MODULE == group, ]
    selected <- rbind(selected, groupRow)
  }
  return(selected)
}


#' Use igraph::mergecoords to make a layout with the chosen modules
#'
#' @param selected df with module name, subgraph and density for the groups with the best density
#' @return layout, df with xy coordinates
makeLayout <- function(selected) {
  subgraphs <- selected$SUBGRAPH
  layouts <- lapply(subgraphs, igraph::layout_nicely)
  lay <- igraph::merge_coords(subgraphs, layouts)
  return(lay)
}



