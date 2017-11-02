library(shiny)
library(ggplot2)
library(dplyr)


shinyUI(
  fluidPage( theme = "cer.css",
    
    #title
    h4("Illustration of Law of Large Numbers & Central Limit Theorem"), br(),
    
    
    #2 tabs - space for 2 plots and their input controls
    tabsetPanel(
      
      #tab1
      tabPanel(h4("LLN"), 
          
        #split layout - 2 plots side by side     
        fluidRow(
              h5("Law of large numbers states that 
                            as the sample size is increased 
                              the sample mean approaches the population mean"),

              splitLayout(cellWidths = c("60%", "40%"),
                    plotOutput("plot1"), plotOutput("plot3")),
                    br(), hr(),
          
        #input controls tab 1              
        fluidRow(
            column(4, offset = 2, 
              h5("Sample size(n)"), 
                  sliderInput("sample", "", min = 1, max = 300, 
                  value = 2, step = 15, round = 0,animate = T)),
                          
            column(4, 
              h5("Lambda Value"),
                  numericInput("lambda","",value = .2, step = .1))
                        )
               )#end fluid row
                ),#end tabPanel 1
      
       #tab2
      tabPanel(h4("CLT"), splitLayout(cellWidths = c("60%", "40%"),
                                  plotOutput("plot2"), plotOutput("plot4")), 
              br(), hr(),
               
          #input controls tab 2
          fluidRow(
              column(5, h5("Sample Size for Sample Means"),
                  sliderInput("sample_mean", "", min = 1, max = 20,
                          value = 1,step = 1, round = 0, animate=T))
               )#end fluid row
                )#end tabPanel 2
      
      )#end tabsetPanel
    
  )#end fluid page
)#end shiny UI
