library(prophet)
library(quantmod)


symbols <- c('TER','SPOT','TWTR', 'NKE')
getSymbols(Symbols = symbols, from = '2013-01-01', auto.assign = TRUE)

df <- data.frame(Date=as.POSIXct(index(NKE)),coredata(NKE)) 

dfs = df[,c(1,4)]
colnames(dfs) = c('ds','y')

m = prophet(dfs)

future = make_future_dataframe(m, periods = 365)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m,forecast)

