library(plotly)
library(prophet)
library(quantmod)


#   Get financial data OHLC format  #
symbols <- c('TER','SPOT','TWTR', 'XOM','TSM','BAC')
tariffs = c("TSN","GM","F","KO",'WHR',"AA","QCOM")

getSymbols(Symbols = tariffs, from = '2013-01-01', auto.assign = TRUE)


#Define function to run prophet on a Stock ------------------------------------------ |
run_prophet = function(symbol){
    df <- data.frame(Date=as.POSIXct(index(symbol)),coredata(symbol)) 
    dfs = df[,c(1,4)]
    colnames(dfs) = c('ds','y')
    m = prophet(dfs)
    future = make_future_dataframe(m, periods = 720)
    forecast <- predict(m, future)
    the_list = list(m, forecast, dfs)
    return(the_list)
}


#-------------------------------------------------------------
# # # #     NON-FUNCTIONALIZED 
#-------------------------------------------------------------
# df <- data.frame(Date=as.POSIXct(index(TER)),coredata(TER)) 
# dfs = df[,c(1,4)]
# colnames(dfs) = c('ds','y   ')
# m = prophet(dfs)
# future = make_future_dataframe(m, periods = 365)
# forecast <- predict(m, future)
# tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])
#--------------------------------------------------------------------------------------- |
# myPars <- chart_pars()
# myPars$mar <- c(3, 2, 0, .2) # default is c(3, 1, 0, 1)  # bottom, left, top, right
# myPars$cex <- 1.5 #' Increase font size of both x and y axis scale ticks
# mychartTheme <- chart_theme()
# mychartTheme$
# mychartTheme$rylab = FALSE  #' Don't show y-axis on right side of plot to save space
# # mychartTheme$lylab = TRUE  #' Show y-axis ticks on left side of plot?  Default is TRUE for both left and right sides.
# chart1 <- chart_Series(TWTR, pars=myPars)#,theme =  mychartTheme)
# chart1

# --- Run Prophet model on a stock and plot the forecast and actual
x = run_prophet(BAC)
m = x[[1]]
forecast = x[[2]]
dfs = x[[3]] 

#basic plot
plot(m,forecast)

#ggplot version
fplot = ggplot(forecast, aes(x = ds, y=trend))+
    geom_line(stat = 'identity') +
    geom_point(data = dfs, aes(x = ds, y = y))
# - # - # - # Functionalizing OHLC Plotly plots for quantmod dfs # - # - # - #

#Define plotly plot function

# make_plot = function(x){
#     i = x %>%
#         plot_ly(x = ~Date, type="ohlc",
#                 open = ~paste(x,"Open",collapse = '.'),
#                 close = ~paste(x,"Close",collapse = '.'),
#                 high = ~paste(x,"High",collapse = '.'),
#                 low = ~paste(x,"Low",collapse = '.')) %>%
#         layout(title = "Basic OHLC Chart")
#     i
#         
# }

#make_plot(df)


df %>%
    plot_ly(x = ~Date, type="ohlc",
            open = ~AAPL.Open, close = ~AAPL.Close,
            high = ~AAPL.High, low = ~AAPL.Low) %>%
    layout(title = "Basic OHLC Chart")

p <- df %>%
    plot_ly(x = ~Date, type="ohlc",
            open = ~AAPL.Open, close = ~AAPL.Close,
            high = ~AAPL.High, low = ~AAPL.Low) %>%
    layout(title = "Basic OHLC Chart")

p

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
# chart_link = api_create(p, filename="finance/ohlc-basic")
# chart_link


# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************

# - **************************************************************************
# - **************************************************************************
# - **************************************************************************




library(Quandl)
library(quantmod)
library(dplyr)
library(ggplot2)
library(nnfor)
Quandl('USTREASURY/REALYIELD', start_date='2018-04-11', end_date='2019-04-11')

symbols <- c('TER','SPOT','TWTR', 'XOM')
# AAPL_f = getFinancials('AAPL')
getSymbols(Symbols = symbols, from = '2013-01-01', auto.assign = TRUE)

dpois(INTC$INTC.Close,rownames(INTC))
getSymbols('XOM', from = '2013-01-01', auto.assign = T)
getFinancials('TWTR')
# - **************************************************************************
# - **************************************************************************
# - **************************************************************************
## Junk 
dpois(BTCUSD$Last,BTCUSD$Date)


#--<<< access xts elements >>>--#
tail(Hi(INTC),1)


#--<<< random: get environment object names >>>--#
ns <- ls(all.names=T, envir=globalenv(), pattern = '[[:upper:]]')


# - **************************************************************************
# - **************************************************************************
# - **************************************************************************



chartSeries(NVDA, subset = 'last 3 months')
addTA(OpCl(NVDA), type='b', lwd=2)
addTA(LoHi(NVDA), type='l', col=3, lwd=2)

#close vs. low
addTA(LoCl(NVDA), type='b', lwd=1, col=5)
#close vs. high
addTA(HiCl(NVDA), type='b', lwd=2, col=4)

C$OpCl <- OpCl(C)
chartSeries(C,subset='last 4 months',major.ticks = 'days')
addTA(OpCl(C),col=4, type='b', lwd=2)

#quandl --->
OIL = Quandl('OPEC/ORB', start_date='2013-01-01')
UNEMP = Quandl('FRED/NROU', start_date='2013-01-01') 
BTCUSD = Quandl('BTCE/USDBTC', start_date='2013-01-01')
NASDAQ = Quandl('NASDAQOMX/NQUSB', start_date='2013-01-01')
NASDAQ <- arrange(NASDAQ,`Trade Date`)


#OIL
NASDAQ <- NASDAQ %>%
    mutate(Trend = c(0,diff(NASDAQ$`Index Value`)),
           YearMonth = as.yearmon(NASDAQ$`Trade Date`))

NQYM <- NASDAQ %>%
    select(YearMonth,`Index Value`) %>%
    group_by(YearMonth) %>%
    summarize(Value = sum(`Index Value`)) %>%
    mutate(Trend = c(0,diff(Value)))

qplot(NASDAQ$`Trade Date`,NASDAQ$`Index Value`, geom = 'line')
# <---

chartSeries(NVDA, subset = 'last 3 months')
addTA(OpCl(NVDA), type='b', lwd=2)
addTA(LoHi(NVDA), type='l', col=3, lwd=2)

#close vs. low
addTA(LoCl(NVDA), type='b', lwd=1, col=5)
#close vs. high
addTA(HiCl(NVDA), type='b', lwd=2, col=4)

C$OpCl <- OpCl(C)
chartSeries(C,subset='last 4 months',major.ticks = 'days')
addTA(OpCl(C),col=4, type='b', lwd=2)
