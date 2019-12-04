# testGetAllPossibleGroups.R

library(igraph)
# Set up Environment
load("./exampleEdge.Rda")
load("./exampleVert.Rda")
graph <- checkValidInput(edges, vert)
moduleGraphs <- makeModuleGraphs(edges, vert)
grouped <- getAllPossibleGroups(graph, vert, moduleGraphs)

test_that("getAllPossibleGroups()", {
  expect_equal(nrow(grouped), 6) #length
  expect_equal(igraph::is_igraph(grouped$SUBGRAPH[[2]]), TRUE) #graph
  expect_equal(floor(grouped$DENSITY[[2]]), 26)
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)
