library(shinythemes)
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = shinytheme("united"),
  tags$style(HTML("
@import url('https://fonts.googleapis.com/css?family=Allerta Stencil');
      
      
      h1 {
        
        font-family: 'Allerta Stencil';
        font-weight: 500;
        line-height: 1.1;
        color: white;
        text-align:center;
       border-radius: 25px;
border-color: #2e6da4;
    background: red;
                  padding: 20px; 
                  width: 100%;
                  height: 50%;
                  margin-top:50px;
                  
        
      }
h4{
margin-left:20%;
color:white;
}
body{

background-color:grey;

}

    ")),
  h1("VTU DATA ANALYSER"),
  sidebarLayout(
    sidebarPanel(tags$style(".well {background-color:red;color:white}"),"",
                 fileInput("file", label = h3("File input")),
                 textInput("text", label = h3("USN"), value = "Enter USN.."),
      selectInput("id","SELECT SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
      actionButton("sub", "SUBMIT", icon("paper-plane"), 
                   style="color: white; background-color: grey; border-color: #2e6da4")
    ),
    mainPanel(
      h4("COMPARE THE SEMESTER SCORES"),
      column(width=4,div(style="width: 100%;",selectInput("comp","SELECT SEMESTER",choices = c(1:8)))),
      column(width=4,div(style="width: 100%;",selectInput("comp","SELECT SEMESTER",choices = c(1:8)))),
      column(width=4,div(style="width: 100%;",actionButton("cmp", "COMPARE", icon("paper-plane"), 
                                                           style="color: white;margin-top:15%; background-color: red; border-color: #2e6da4")))
    )
  )
  
  
  )


server <- function(input, output, session) {
  
}

shinyApp(ui, server)


