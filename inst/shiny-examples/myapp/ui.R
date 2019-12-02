# ui.R

library(shiny)

#' Define UI for dataset viewer application
#'
#' @import shiny
shinyUI(pageWithSidebar(
  # Adapted from: https://shiny.rstudio.com/articles/tabsets.html
  # Application title
  headerPanel("Explore modCluster"),

  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    selectInput("communityFlag", "Customize Output: flag displays communities and edge types when true",
                choices = c(TRUE, FALSE)),
    selectInput("dataset", "Customize Input: explore example data inputs",
                choices = c("verticies", "edges")),

  ),

  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Output", plotOutput("plot")),
                tabPanel("Inputs", tableOutput("view"))
    )
  )
))

