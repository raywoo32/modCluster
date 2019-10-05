# testChooseGroups.R


# Set up Environment
load("./exampleEdge.Rda")
load("./exampleVert.Rda")
graph <- checkValidInput(edges, vert)
moduleGraphs <- makeModuleGraphs(edges, vert)
grouped <- getAllPossibleGroups(graph, vert, moduleGraphs)
sorted <- makeSortedCompare(moduleGraphs, grouped)
bestGroups <- chooseBestGroups(sorted, 1)
chosen <- getChosenMods(bestGroups, moduleGraphs, grouped)
layout <- makeLayout(chosen)


test_that("getChosenMods()", {
  expect_equal(as.character(chosen$MODULE[1]), "1 4")
  expect_equal(igraph::is_igraph(chosen$SUBGRAPH[[1]]), TRUE)
  expect_equal((chosen$DENSITY[[1]]), 35.25)


})

test_that("makeLayout()", {
  expect_equal(nrow(layout), 11)
  expect_equal(ncol(layout), 2)
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)

