# testChooseGroups.R

library(igraph)

# Set up Environment
load("./exampleEdge.Rda")
load("./exampleVert.Rda")
graph <- checkValidInput(edges, vert)
moduleGraphs <- makeModuleGraphs(edges, vert)
grouped <- getAllPossibleGroups(graph, vert, moduleGraphs)
sorted <- makeSortedCompare(moduleGraphs, grouped)
bestGroups <- chooseBestGroups(sorted, 1)

test_that("makeSortedCompare()", {
  skip("No internet connection")

  expect_equal(floor(sorted[1,2]), 35)
  expect_equal(as.character(sorted$MODULE[1]), "1 4")
  expect_equal(as.character(sorted$MODULE[2]), "1")
  expect_equal(floor(sorted[2,2]), 34)
})

test_that("chooseBestGroups()", {
  skip("No internet connection")

  expect_equal(bestGroups[[1]], "1 4") #length
  expect_equal(bestGroups[[2]], "2 3") #length
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)

