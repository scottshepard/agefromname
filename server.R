library(shiny)
library(babynames)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(ssalifetablesextended)
library(cwhmisc)

source("functions.R")

shinyServer(function(input, output) {
    
  observeEvent(input$go, {
    age_table <- ageTableFor(input$name, input$sex)
    zigger_zagger <- ziggerZagger(age_table)
    output$zigger_zagger <- renderPlot(zigger_zagger)
  })
})