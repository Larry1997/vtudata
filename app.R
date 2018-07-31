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
                  background: #36e9ee;
                  padding: 20px; 
                  width: 100%;
                  height: 50%;
                  margin-top:50px;
                  
                  
                  }
                  h4{
                  margin-left:20%;
                  color:black;
                  }
                  body{
                  
                  background-color:#white;
                  
                  }
                  
                  ")),
  h1("VTU DATA ANALYSER"),
  sidebarLayout(
    sidebarPanel(tags$style(".well {background-color:#36e9ee;color:white}"),"",
                
                 h3(("Analyse student Marks")),
                 HTML("  <br>"),
                 actionButton("sub1", "SEM-WISE", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 HTML("<br>  <br>"),
                 actionButton("sub2", "All-SEM", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 HTML("<br>  <br>"),
                 h3(("Compare two sem  marks")),
                 actionButton("sub3", "Compare", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 HTML("<br>  <br>"),
                 h3(("Semester performance")),
                 actionButton("sub4", "Get performance", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 HTML("<br>  <br>"),
                 h3(("All Semester performance")),
                 actionButton("sub5", "Get performance", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4")
                 
                 
    ),
    
    
    
    
    
    
    mainPanel(
      textOutput("txt1")
      
    )
  )
  
  
  )


server <- function(input, output, session) {(
  output$txt1<-renderText(
    if(input$sub1){
      paste("sub1")
      
    }
      if(input$sub2)
        {
      paste("sub2")

        }
   #  if(input$sub3){
   #    paste("sub3")
   #    
   #  }
   #  if(input$sub3){
   #    paste("sub4")
   #    
   #  }
   #  if(input$sub3){
   #    paste("sub5")
   #    
   #  }
    
  )
)
}

shinyApp(ui, server)


