
library(igraph)

# Set up Environment
load("exampleEdge.Rda")
load("exampleVert.Rda")

test_that("Throw error for bad input edges", {
  expect_error(checkValidInput(edges[, c(1,3)], vert))
})

test_that("Throw error for bad input vertex", {
  expect_error(checkValidInput(edges, vert$NAME))
})

test_that("Give graph for valid input", {
  valid <- checkValidInput(edges, vert)
  expect_equal(igraph::is_igraph(valid), TRUE)
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)
