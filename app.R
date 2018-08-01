library(shinythemes)
library(shiny)
library(shinyWidgets)
library(shinyjs)

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
                 fileInput("file1", "Choose CSV File",
                           accept = c(
                             "text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")
                 ),
                 
                 # fileInput("file", label = h3("File input")),
                 #actionButton("sub4", "Submit", icon("paper-plane"), 
                 #        style="width:150px;margin-left:120px;margin-top:-10%;color: white; background-color: grey; border-color: #2e6da4"),
                 useShinyjs(), 
                 HTML("<br>"),
           
                 tags$div(id='btsem',class="inner",actionButton("sem", "Semester")),
                 tags$div(id='btstudent',class="inner",actionButton("st", "Student"))
                 
                
                 ,tags$hr(),
                 
                 
                 
                 
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
                                 actionButton("sub4", "Sem Performance", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4"),
                                 
                                 
                                 #HTML("<br>  <br>"),
                                 #h3(("All Semester performance")),
                                 actionButton("sub5", "All Sem Performance", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4")
                                 
                 )),
                 
                 hidden(tags$div(id="btsemwise",
                                 h4(("Analyse student sem Marks")),
                                 textInput("usn", value="4so15cs001" ,label = h4("USN"), placeholder  = "Enter USN.."),
                                 selectInput("semnum","SELECT SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
                                 actionButton("plotsw", "Plot", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4")
                                 
                 )),
                 hidden(tags$div(id="btallsem",
                                 h4(("Analyse student all sem Marks")),
                                 textInput("usn2", value="4so15cs001" ,label = h4("USN"), placeholder  = "Enter USN.."),
                                 actionButton("plotas", "Plot", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4")
                                 
                 )),
                 
                 hidden(tags$div(id="btsemcom",
                                 h4(("Comparision Bitween 2 sems")),
                                 
                                 selectInput("semnum2","SELECT 1st SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
                                 selectInput("semnum3","SELECT 2nd SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
                                 actionButton("plotcom", "Let's Go", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4")
                                 
                 )),
                 
                 hidden(tags$div(id="btperf",
                                 h4(("Performance Per Semester")),
                                 
                                 selectInput("semnum4","SELECT 1st SEMESTER",choices = c("1","2","3","4","5","6","7","8")),
                                 actionButton("plotperf", "Let's Go", icon("paper-plane"), 
                                              style="color: white; background-color: grey; border-color: #2e6da4")
                                 
                 ))
                 
                 
    ),
    
    
    
    
    
    
    
    mainPanel(
      textOutput("distPlot"),
      plotOutput("plot")
      
      
    )
  )
  
  
  )


server <- function(input, output, session) {
#comment delete  
  
  observeEvent(input$plotsw, {
    
    output$plot<-renderPlot({
      
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      stud<-read.csv(inFile$datapath, header = T)
      
      #Extracting the required data
      reqdata<-stud[which(stud$Usn==input$usn & stud$Semester==input$semnum),c(2,4:12)]
      
      #Extracting all subjects marks
      marks_data<-reqdata[c(2:9)]
      
      #Converting marks into vector
      marks_vector<-as.vector(t(marks_data))
      
      #Creating a title for our plot with name and sgpa
      title<-paste(toString(reqdata$Name),".  SGPA= ", toString(reqdata$SGPA))
      
      #plotting a bar graph
      barplot(marks_vector, main=title, xlab="Subjects",col="magenta",ylim=c(0,100),
              ylab="Marks", names.arg=c("s1","s2","s3","s4","s5","s6","s7","s8"), 
              border="blue",ann=F)
      
      
    })
    
  })
  
  observeEvent(input$plotas, {
    
    output$plot<-renderPlot({
      
      inFile <- input$file1
      
      if (is.null(inFile))
       { return(NULL)
      }
     
      
      stud<-read.csv(inFile$datapath, header = T)
      
      reqdata<-stud[which(stud$Usn==input$usn2),c(2,3,12)]
      
      #title for the plot
      title<-toString(reqdata$Name[1])
      
      #plotting a line graph
      plot(reqdata$Semester,reqdata$SGPA, main=title, type="o", col="blue",ylim = c(1,10),xlab="Semesters",
           ylab="SGPA")
      
      
    })
    
  })
  
  observeEvent(input$plotcom, {
    
    output$plot<-renderPlot({
      
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      stud<-read.csv(inFile$datapath, header = T)
      
      sem1<-stud[which(stud$Semester==input$semnum2 & stud$Usn=="4so15cs001"),c(4:11)]
      sem2<-stud[which(stud$Semester==input$semnum3 & stud$Usn=="4so15cs001"),c(4:11)]
      sem1<-as.vector(t(sem1))
      sem2<-as.vector(t(sem2))
      plot(sem1,type="o", col="blue",ylim = c(1,100), ann=FALSE)
      box()
      
      # Graph trucks with red dashed line and square points
      lines(sem2, type="o", pch=22, lty=2, col="red")
      
      # Create a title with a red, bold/italic font
      title(main="Performance", col.main="red", font.main=4)
      
      # Label the x and y axes with dark green text
      title(xlab="Subjects", col.lab=rgb(0,0.5,0))
      title(ylab="marks", col.lab=rgb(0,0.5,0))
      
      # Create a legend at (1, g_range[2]) that is slightly smaller 
      # (cex) and uses the same line colors and points used by 
      # the actual plots 
      legend(1, 25, c("sem1","sem2"), cex=0.8, 
             col=c("blue","red"), pch=21:22, lty=1:2)
      
      
    })
    
  })
  
  
  observeEvent(input$plotperf, {
    
    output$plot<-renderPlot({
      
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      stud<-read.csv(inFile$datapath, header = T)
      
      
      #Extracting semester and sgpa of student
      reqdata<-stud[which(stud$Semester==input$semnum4),c(12,13)]
      dist=0
      avg=0
      fail=0
      
      
      fail_count<- subset(reqdata[,c(1)] ,reqdata$Result=='F'|reqdata$Result=='f')
      fail<-length(fail_count)
      
      pass_count<-subset(reqdata[,c(1)],reqdata$Result=='P'|reqdata$Result=='p')
      for(i in pass_count)
      {
        if(i>=7.5)
        {
          dist=dist+1
        }
        else{
          avg=avg+1
        }
      }
      
      colors <- c("white","grey70","black")
      data_vector<-c(dist,avg,fail)
      data_labels <- round(data_vector/sum(data_vector) * 100, 1)
      data_labels <- paste(data_labels, "%", sep="")
      
      pie(data_vector, main="Performance", col=colors, labels=data_labels,
          cex=0.8)
      
      # Create a legend at the right   
      legend(1.5, 0.5, c("Distinction","Average","Fail"), cex=0.8, 
             fill=colors)
    })
    
  })
  
  observeEvent(input$st, {
   
    
    if (is.null(input$file1)){
      showModal(modalDialog(
        title = "File upload failed.",
        paste0("Select a valid file"),
    easyClose = TRUE,
    footer = NULL
  ))
      return(NULL)
    }
    else{
      show(id="btnst")
      hide(id="btnsem")
    }
    
  })
  
  observeEvent(input$sub1, {
    hide(id="btallsem")
    hide(id="btsemcom")
    show(id="btsemwise")
    
    
  })
  
  observeEvent(input$sub2, {
    hide(id="btsemwise")
    hide(id="btsemcom")
    show(id="btallsem")
  })
  
  observeEvent(input$sub3, {
    hide(id="btsemwise")
    hide(id="btallsem")
    show(id="btsemcom")
    
  })
  observeEvent(input$sem, {
    
    if (is.null(input$file1)){
      showModal(modalDialog(
        title = "File upload failed.",
         paste0("Select a valid file"),
        easyClose = TRUE,
        footer = NULL
      ))
      return(NULL)
    }
      else{
    hide(id="btnst")
    hide(id="btsemwise")
    hide(id="btallsem")
    hide(id="btsemcom")
    show(id="btnsem")
      }
    
  })
  
  observeEvent(input$sub4, {
    show(id="btperf")
  })
  
  observeEvent(input$sub5, {
    
  })
  
  
}

shinyApp(ui, server)


