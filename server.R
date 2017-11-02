library(shiny)
library(ggplot2)
library(dplyr)


shinyServer(function(input, output) {
  
 data <- reactive({
   
   #reqactive df for plots on the tab1
   data_frame( a = (1:input$sample), 
               b=(cumsum(rexp(input$sample, input$lambda))/a),
               c = rexp(input$sample, input$lambda))  
  
 })
  
 #create the arrow used for axis lines
 arrow <- arrow(length = unit(0.4, "cm"), type = "closed")
 
  #plot1 on tab1
  output$plot1 <- renderPlot(
    (ggplot(data(), aes(data()[,1], data()[,2])) + 
       geom_line(color="orange",size=1.5)+
       geom_hline(yintercept = (1/input$lambda)) + 
       scale_y_continuous(limits= c(((1/input$lambda)-3),((1/input$lambda)+5)))+
       scale_x_continuous(limits = c(0,310))+
       labs(title= "Sample Mean vs Sample Size", subtitle = 'For large sample size("n"), Sample mean approaches Theoretical mean' ,
            y= "Sample Mean", x= 'Sample Size("n")')+
       theme(plot.title= element_text(face = "bold",size = 20, color= "red"), 
             axis.title = element_text(face = "bold", size = 16, color= "blue"))+
       theme_grey(base_size = 13)+ theme(axis.line = element_line(arrow = arrow))+
       annotate("text", x = 280, y = (1/input$lambda)+1, label= "Theoritical mean", size=4, color="red")+
       geom_segment(aes(x=280,xend=280, y = (1/input$lambda)+.9, yend=(1/input$lambda)+.1),arrow = arrow)
     ) 
  )
  
  #plot2 on tab2
  output$plot3 <- renderPlot(
    (ggplot(data(), aes(data()[,3]))+ 
       stat_density( fill="red",alpha=.4) +
       geom_vline(xintercept = (1/input$lambda), color="blue")+
       labs(title= "Distribution of Samples", x= "")+
       theme(plot.title= element_text(face = "bold",size = 20, color= "red"))+
       scale_x_continuous(limits = c(-5,35))+
       scale_y_continuous(limits = c(0,.18))+
       theme_grey(base_size = 12)
      
    )
  )
  
  #reactive df for tab2 
  data1 <- reactive({
     
    ran <- rexp(n =(input$sample_mean* 1000), rate = input$lambda)    
    data2 <- as.data.frame( split(ran, 
                        ceiling(seq_along(ran)/(1000)))
                        )
    data2$mean <- rowMeans(data2)
    return(data2)
    
  }) 
  
  
  output$plot2 <- renderPlot(
    (ggplot(data1() ) + geom_histogram(aes(data1()$mean, ..density..), 
                                       binwidth = .3, alpha = .7)+
       geom_density(aes(data1()$mean), fill="red", alpha = .3)+
       scale_x_continuous(limits = c(-10,30))+
       scale_y_continuous(limits = c(0,0.4))+
      labs(title = "Distribution of Sample Means",x ="",
           subtitle= "For larger n, std. deviation decreses and the distribution looks similar to normal distribution")+
      theme(plot.title= element_text(face = "bold",size = 20, color= "red"), 
            axis.title = element_text(face = "bold", size = 16, color= "blue"))+
       geom_vline(xintercept = 1/input$lambda, color = "blue", alpha=.7)+
       geom_vline(xintercept =mean(data1()$mean)+(sqrt(var(data1()$mean))*3))+
       geom_vline(xintercept =mean(data1()$mean)-(sqrt(var(data1()$mean))*3))+
       theme_grey(base_size = 13)+ theme(axis.line = element_line(arrow = arrow)) +
       geom_segment(aes(x = mean(data1()$mean)+(sqrt(var(data1()$mean))*3), 
                        xend=mean(data1()$mean)-(sqrt(var(data1()$mean))*3),
                        y =.35, yend=.35 ), arrow = arrow(ends="both", 
                                                          length =unit(.4,"cm")))+
       annotate("text", x=1/input$lambda, y=.38, label="+/- 3 Std. Deviation", color="red")
       
    )
  )
  
  output$plot4 <- renderPlot(
    
    (ggplot(data1(), aes(sample= data1()$mean)) + stat_qq(color= "orange")+
      scale_y_continuous(limits = c(-2,25))+
      scale_x_continuous(limits = c(-3,3))+
      labs(title = "Q-Q Plot")+
      theme(plot.title= element_text(face = "bold",size = 20, color= "red"), 
            axis.title = element_text(face = "bold", size = 16, color= "blue"))+
       theme_grey()
      )
  )
  
  
  
})