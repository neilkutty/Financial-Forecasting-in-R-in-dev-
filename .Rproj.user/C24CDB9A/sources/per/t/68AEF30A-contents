# - **************************************************************************
library(Quandl)
library(quantmod)
library(dplyr)
library(plotly)
library(ggplot2)
library(prophet)
#library(nnfor)

# x=Quandl('USTREASURY/REALYIELD', start_date='2018-04-11')
# symbols <- c('NKE','SPOT','TWTR', 'XOM', 'NVDA', 'TER', 'BAC')
# # AAPL_f = getFinancials('AAPL')
# getSymbols(Symbols = symbols, from = '2013-01-01', auto.assign = TRUE)
# getSymbols('BAC', from = '2001-01-01', auto.assign = TRUE)
# getSymbols('NVDA', from = '1990-01-01', auto.assign = TRUE)

#------------------------------------------------------------------------------------ /
#Define function to run prophet on a Stock ------------------------------------------ |
run_prophet = function(symbol, from){
    symbol = getSymbols(symbol, from = from, auto.assign = F)
    df <- data.frame(Date=as.POSIXct(index(symbol)),coredata(symbol)) 
    dfs = df[,c(1,4)]
    colnames(dfs) = c('ds','y')
    m = prophet(dfs)
    future = make_future_dataframe(m, periods = 720)
    forecast <- predict(m, future)
    the_list = list(m, forecast, dfs, symbol)
    return(the_list)
}


#------------------------------------------------------------------------------------ \
# --- Run Prophet model on a stock and plot the forecast and actual
x = run_prophet('NVDA', '2015-01-01')
m = x[[1]]
forecast = x[[2]]
dfs = x[[3]] 
stock = x[[4]]

plot(m,forecast)
ggp = ggplot(forecast, aes(x = ds, y=trend))+
    geom_line(stat = 'identity') +
    geom_point(data = dfs, aes(x = ds, y = y))
ggplotly(ggp)

# ------------- TEST - - - TEST - - - TEST ---------- ### ------------- TEST - - - TEST - - - TEST ---------- ##
# ------------------------------------------------------------------------------------------------------------##
# ------------- TEST - - - TEST - - - TEST QUANTMOD LIBRARY EXPLORE FXs TEST - - - TEST - - - TEST ---------- ##
# ------------------------------------------------------------------------------------------------------------##
# ------------- TEST - - - TEST - - - TEST ---------- ### ------------- TEST - - - TEST - - - TEST ---------- ##

#List of fundamentals available
yahooQF()

AAPL_Qt = getQuote("AAPL", what = yahooQF(c("Market Capitalization", "Earnings/Share")))

AAPL_Qt = getQuote("AAPL", what = yahooQF(c("Market Capitalization", "Earnings/Share", 
                                            "P/E Ratio", "Book Value", "EBITDA", 
                                            "Price/Book")))

