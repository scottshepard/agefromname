library(shiny)
library(babynames)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(ssalifetablesextended)
library(cwhmisc)
library(Hmisc)

source("functions.R")

shinyServer(function(input, output) {
  observeEvent(input$go, {
    name <- Hmisc::capitalize(tolower(input$name))
    age_table <- ageTableFor(name, input$sex)
    zigger_zagger <- ziggerZagger(age_table)
    output$zigger_zagger <- renderPlot(zigger_zagger)
    
    name_stats_text <- nameStatsText(name, nameStats(age_table))
    output$born <- renderText(name_stats_text$born)
    output$alive <- renderText(name_stats_text$alive)
    output$median_age <- renderText(name_stats_text$median_age)
    output$peak <- renderText(name_stats_text$peak)
  })
})
