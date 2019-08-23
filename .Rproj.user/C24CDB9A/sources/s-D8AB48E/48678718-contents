##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
##  original quantmod rshiny code: http://shiny.rstudio.com/tutorial/lesson6/


library(quantmod)
library(ggplot2)
library(prophet)
library(shinycssloaders)


shinyServer(function(input, output) {
  
  indicators <- list("addMACD()","addVo()","addBBands()")
  
  themeselect <- reactive({input$themeselection})
  
  dataInput <- reactive({ 
    
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  prophecy <- reactive({
    
    df <- data.frame(Date=as.POSIXct(index(dataInput())),coredata(dataInput())) 
    dfs = df[,c(1,4)]
    colnames(dfs) = c('ds','y')
    m = prophet(dfs)
    future = make_future_dataframe(m, periods = 720)
    forecast <- predict(m, future)
    the_list = list(m, forecast, dfs)
  })
  

  
  output$plot <- renderPlot({
  
      chartSeries(dataInput(), name = input$symb, theme = input$themeselection, 
              type = input$charttype, log.scale = input$log, TA = indicators)
  })
  
  output$plot2 <- renderPlot({
    m = prophecy()[[1]]
    forecast = prophecy()[[2]]
    plot(m,forecast)
  })
  
})

