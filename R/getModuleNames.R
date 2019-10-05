# getModuleNames.R

#' Helper function that converts modules from string to vector
#'
#' @param mods string representing modules
#' @return vector of modules
getModuleNames <- function(mods) {
  split<- (strsplit(mods, " "))[[1]]
  return(split)
}
