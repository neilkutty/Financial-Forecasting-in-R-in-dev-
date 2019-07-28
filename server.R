##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
## 3/9/2018 -- Add a way to choose indicators and multiple charts :)
## 7/8/2019 -- Incorporate prophet then LSTM 


library(quantmod)
#library(Quandl)
library(ggplot2)
library(prophet)



# OIL = Quandl('OPEC/ORB', start_date='2013-01-01')
# NASDAQ = Quandl('NASDAQOMX/NQUSB', start_date='2013-01-01')


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
  
 
  
#   
#  # ------ BELOW IN DEV -----------__----------__----_---__---- 
#   exprophet <- reactive({
#     x = run_prophet(input$symb)
#     m = x[[1]]
#     forecast = x[[2]]
#     dfs = x[[3]] 
#     
#     #basic plot
#     prophplot = plot(m,forecast)
#     
#   })
#   
#   prophPlot <- renderPlot({
#     plot()
#   })
# # ------ ABOVE IN DEV -----------__----------__----_---__----  
#  
  
  output$plot <- renderPlot({
  
      chartSeries(dataInput(), name = input$symb, theme = input$themeselection, 
              type = input$charttype, log.scale = input$log, TA = indicators)
  })
  
  output$plot2 <- renderPlot({
    m = prophecy()[[1]]
    forecast = prophecy()[[2]]
    plot(m,forecast)
  })
  
  
  # output$fplot <- renderPlot({
  # 
  #   run_prophet = function(symbol){
  #     df <- data.frame(Date=as.POSIXct(index(symbol)),coredata(symbol)) 
  #     dfs = df[,c(1,4)]
  #     colnames(dfs) = c('ds','y')
  #     m = prophet(dfs)
  #     future = make_future_dataframe(m, periods = 720)
  #     forecast <- predict(m, future)
  #     the_list = list(m, forecast, dfs)
  #     return(the_list)
  #   }
  #   
  #   m = x[[1]]
  #   forecast = x[[2]]
  #   dfs = x[[3]] 
  #   
  #   #basic plot
  #   plot(m,forecast)
  # })
  
  # 
  # output$text <- renderText({
  #     print(paste(input$symb,' Last:',tail(Cl(dataInput()),1)))
  # })
  # 
  # output$oil <- renderPlot({
  #   qplot(OIL$Date,OIL$Value, geom='line')
  #   
  # })
  # 
  # 
  # output$unemp <- renderPlot({
  #     qplot(NASDAQ$`Trade Date`,NASDAQ$`Index Value`, geom = 'line')
  # })
  
  # output$plotly <- renderPlot({
  #     #### use code at top of q.R converted for use with input$symb
  # })
})

