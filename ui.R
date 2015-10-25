library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("united"),
  
  titlePanel("How Old is that Name?"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "First Name", value = ""),
      radioButtons("sex", "Sex", c("M", "F"), selected = "M"),
      actionButton('go', "GO!")
    ),
    
    mainPanel(
      plotOutput("zigger_zagger"),
      HTML("</br>"),
      textOutput("born"),
      textOutput("alive"),
      textOutput("median_age"),
      textOutput("peak")
    )
  )
))