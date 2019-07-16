##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
## 3/9/2018 -- Add a way to choose indicators and multiple charts :)
## 7/8/2019 -- Incorporate prophet then LSTM 


library(quantmod)
library(Quandl)
library(ggplot2)


OIL = Quandl('OPEC/ORB', start_date='2013-01-01')
NASDAQ = Quandl('NASDAQOMX/NQUSB', start_date='2013-01-01')


shinyServer(function(input, output) {
  
  indicators <- list("addMACD()","addVo()","addBBands()")
  
  themeselect <- reactive({input$themeselection})
  
  dataInput <- reactive({ 
  
      getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
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
  
  output$oil <- renderPlot({
      qplot(OIL$Date,OIL$Value, geom='line')
      
  })
  
  output$text <- renderText({
      print(paste(input$symb,' Last:',tail(Cl(dataInput()),1)))
  })
  
  output$unemp <- renderPlot({
      qplot(NASDAQ$`Trade Date`,NASDAQ$`Index Value`, geom = 'line')
  })
  
  output$plotly <- renderPlot({
      #### use code at top of q.R converted for use with input$symb
  })
})

