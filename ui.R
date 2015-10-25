library(shiny)

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("How Old is that Name?"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "First Name", value = ""),
      radioButtons("sex", "Sex", c("M", "F"), selected = "M"),
      actionButton('go', "GO!")
    ),
    
    mainPanel(
      plotOutput("zigger_zagger")
    )
  )
))