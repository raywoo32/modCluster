## ----setup, include=FALSE------------------------------------------------
require("devtools")
devtools::install_github("raywoo32/modCluster", vignettes = TRUE)
library("modCluster")


## ----example-------------------------------------------------------------
library(modCluster)
load("./data/exampleEdge.Rda")
load("./data/exampleVert.Rda")
clusterByModule(edges, vert, displayCommunity=FALSE)
clusterByModule(edges, vert, displayCommunity=TRUE)


## ------------------------------------------------------------------------
sessionInfo()

