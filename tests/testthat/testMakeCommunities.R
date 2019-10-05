# testMakeCommunities.R


library(igraph)


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
communitiesOutput <- makeCommunities(graph, chosen)
communities <- communitiesOutput$communities
communitiesList <- communitiesOutput$legend
membership <- communitiesOutput$membership


test_that("communities returns communities", {
 expect_equal(communities$membership[[1]], 1)
})

test_that("communities returns communitiesList", {
  expect_equal(communitiesList[[1]], "1 4")
})

test_that("communities returns membership", {
  expect_equal(length(membership), 11)
})


# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)

