# testMakeModuleGraphs.R

library(igraph)

# Set up Environment
load("../../data/exampleEdge.Rda")
load("../../data/exampleVert.Rda")
moduleGraphs <- makeModuleGraphs(edges, vert)

test_that("Valid objects in moduleGraphs", {
  expect_equal(igraph::is_igraph(moduleGraphs$SUBGRAPH[[2]]), TRUE) #graph
  expect_equal(moduleGraphs$MODULE[[2]], "2") #module name
  expect_equal(moduleGraphs$DENSITY[[2]], 0) #density
  expect_equal(as_edgelist(moduleGraphs$SUBGRAPH[[1]])[1,1], "ZK795.2")
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)
