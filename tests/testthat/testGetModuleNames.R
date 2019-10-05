
mods1 <- "1 2 3"
mods2 <- "1"
mods3 <- "Cat dog bat"

test_that("getModuleNames()", {
  expect_equal(getModuleNames(mods1), c("1", "2", "3")) #graph
  expect_equal(getModuleNames(mods2), "1") #module name
  expect_equal(getModuleNames(mods3), c("Cat", "dog", "bat")) #density
})

# Unload Environment
on.exit(
  rm(list = ls(all.names = TRUE))
)
