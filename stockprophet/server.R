##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
##  original quantmod rshiny code: http://shiny.rstudio.com/tutorial/lesson6/


library(quantmod)
library(ggplot2)
library(prophet)



shinyServer(function(input, output) {
  
  indicators <- list("addMACD()","addVo()","addBBands()")
  
  themeselect <- reactive({input$themeselection})
  
  dataInput <- reactive({ 
    
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    })
 
  
# prophecy function runs fb prophet model and returns list of objects   
prophecy <- reactive({
    
    df <- data.frame(Date=as.POSIXct(index(dataInput())),coredata(dataInput())) 
    dfs = df[,c(1,4)]
    colnames(dfs) = c('ds','y')
    
    #Look into adding changepoint vector in prophet below
    m = prophet(dfs)
    future = make_future_dataframe(m, periods = 30)
    forecast <- predict(m, future)
    the_list = list(m, forecast, dfs)
  })
  

  
  output$plot <- renderPlot({
  
      chartSeries(dataInput(), name = input$symb, theme = input$themeselection, 
              type = input$charttype, TA = indicators)
  })
  
  output$symb_name <- renderText({ 
    paste("You have selected: ", toupper(input$symb))
  })
  
  output$proph_label <- renderText({ 
    paste("FB Prophet price forecast for ", 
          getQuote(input$symb, what = yahooQF(c("Symbol","Name (Long)", "Last Trade (Price Only)")))$NameLong,
          "(",toupper(input$symb),")",
          " over the next 180 days")
  })
  
  output$plot2 <- renderPlot({
    m = prophecy()[[1]]
    forecast = prophecy()[[2]]
    plot(m,forecast)
  })
  
  output$table1 <- renderTable({
    t = getQuote(input$symb, what = yahooQF(c("Symbol", "Name (Long)", "Last Trade (Price Only)",
                                              "Market Capitalization","Earnings/Share",
                                              "EPS Forward", "P/E Ratio", "Book Value", "EBITDA", 
                                              "Price/Book", "Percent Change From 50-day Moving Average",
                                              "Percent Change From 200-day Moving Average"))
                 )
    names(t)[3] = 'Name'
    t = t[,-c(1)]
    
  })
  
  output$plot3 <- renderPlot({
    plot(diff(log(dataInput()[,4]),lag=2), main = 'Log Returns')
    # stock = diff(log(dataInput()[,4]),lag=1)
    # stock = stock[!is.na(stock)]
    # plot(stock,type='l', main='log returns plot')
  })
  # 
  # output$text1 <- renderText({
  #   fit = arima(diff(log(dataInput()[,4]),lag=2), order = c(2, 0, 2),include.mean=FALSE)
  #   summary(fit)
  #   
  #   
  # })
  
})

