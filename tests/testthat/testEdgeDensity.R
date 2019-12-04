# TO TEST: devtools::test()

library(igraph)
# Set up Environment
load("./exampleEdge.Rda")
load("./exampleVert.Rda")
edgesNoWeight <- edges[,c(1,2)]
graphWeight <- igraph::graph_from_data_frame(edges, directed = FALSE, vertices = vert)
graphNoWeight <- igraph::graph_from_data_frame(edgesNoWeight, directed = FALSE, vertices = vert)

context("running edge density")

test_that("edges are loaded", {
  expect_equal(length(edges$GENE1), 15)
})

test_that("Edge Density works for weighted", {
  expect_equal(floor(edge_density(graphWeight)), floor(24.03636))
})

test_that("Edge Density works for unweighted", {
  expect_equal(edge_density(graphNoWeight), igraph::edge_density(graphNoWeight))
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)

