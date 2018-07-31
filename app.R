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
      .inner
{
  display: inline-block;
  }
                  
                  ")),
  h1("VTU DATA ANALYSER"),
  sidebarLayout(
    sidebarPanel(tags$style(".well {background-color:#36e9ee;color:white}"),"",
                 fileInput("file", label = h3("File input")),
                 actionButton("sub4", "Submit", icon("paper-plane"), 
                              style="width:150px;margin-left:120px;margin-top:-10%;color: white; background-color: grey; border-color: #2e6da4"),
                 useShinyjs(), 
                 HTML("<br>"),
                 tags$div(id='btsem',class="inner",actionButton("sem", "Semester")),
                 tags$div(id='btstudent',class="inner",actionButton("st", "Student")),tags$hr(),
                 
                 
                 
                 hidden(tags$div(id="btnst",actionButton("sub1", "SEM-WISE", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 #HTML("<br>  <br>"),
                 actionButton("sub2", "All-SEM", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"),
                 #HTML("<br>  <br>"),
                 #h3(("Compare two sem  marks")),
                 actionButton("sub3", "Compare", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"))),
                 #HTML("<br>  <br>"),
                 
              hidden(tags$div(id="btnsem",    
             #h3(("Semester performance")),
             actionButton("sub4", "Get performance", icon("paper-plane"), 
                   style="color: white; background-color: grey; border-color: #2e6da4"),
        
                 
                 #HTML("<br>  <br>"),
                 #h3(("All Semester performance")),
                 actionButton("sub5", "Get performance", icon("paper-plane"), 
                              style="color: white; background-color: grey; border-color: #2e6da4"))),
             hidden(tags$div(id="btsemwise",
                             h3(("Analyse student Marks")),
                             textInput("usn", value="4so15cs001" ,label = h4("USN"), placeholder  = "Enter USN.."),
                             selectInput("semnum","SELECT SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
                             actionButton("plotsw", "Plot", icon("paper-plane"), 
                                          style="color: white; background-color: grey; border-color: #2e6da4")
                             
                             ))
                 
      
                 
                 
                            
    ),
    
  
    
    
    
    
    
    mainPanel(
   textOutput("distPlot"),
   plotOutput("bar1", width = "100%", height = "100px")
      
    )
  )
  
  
  )


server <- function(input, output, session) {
  
  
  observeEvent(input$plotsw, {
    output$distPlot <- renderText({
      "hai"
    })
    output$bar1<-renderPlot(
      
      #Reading csv file
      read.csv("result.csv",header = T)->stud,
      #Extracting the required data
      reqdata<-stud[which(stud$Usn==input$usn & stud$Semester==input$semnum),c(2,4:12)],
      
      #Extracting all subjects marks
      marks_data<-reqdata[c(2:9)],
      
      #Converting marks into vector
      marks_vector<-as.vector(t(marks_data)),
      
      #Creating a title for our plot with name and sgpa
      title<-paste(toString(reqdata$Name),".  SGPA= ", toString(reqdata$SGPA)),
      
      #plotting a bar graph
      barplot(marks_vector, main=title, xlab="Subjects",col="magenta",ylim=c(0,50),
              ylab="Marks", names.arg=c("s1","s2","s3","s4","s5","s6","s7","s8"), 
              border="blue",ann=F)
    )
    
  })
  
  observeEvent(input$st, {
    show(id="btnst")
    hide(id="btnsem")
    
  })
  
  observeEvent(input$sub1, {
   show(id="btsemwise")
    
    
  })
  
  observeEvent(input$sub2, {
    output$distPlot <- renderText({
      "hai"
    })
  })
  
  observeEvent(input$sub3, {
    show(id="jai")
    output$distPlot <- renderText({
      "hey3"
    })
  })
  observeEvent(input$sem, {
    hide(id="btnst")
    show(id="btnsem")
    
  })
  
  observeEvent(input$sub4, {
    output$distPlot <- renderText({
      "hey4"
    })
  })
  
  observeEvent(input$sub5, {
    output$distPlot <- renderText({
      "hey5"
    })
  })
  
 
  
  

}

shinyApp(ui, server)


