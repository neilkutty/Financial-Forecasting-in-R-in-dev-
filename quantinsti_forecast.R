# From https://www.quantinsti.com/blog/forecasting-stock-returns-using-arima-model/

library(quantmod);
library(tseries);
library(timeSeries);
library(forecast);
library(xts);

# Pull data from Yahoo finance 
TECHM = getSymbols('TECHM.NS', from='2012-01-01', to='2015-01-01',auto.assign = FALSE)
TECHM = na.omit(TECHM)

# Select the relevant close price series
stock_prices = TECHM[,4]

# Compute the log returns for the stock
stock = diff(log(stock_prices),lag=1)
stock = stock[!is.na(stock)]

# Plot log returns 
plot(stock,type='l', main='log returns plot')

# Conduct ADF test on log returns series
print(adf.test(stock))

breakpoint = floor(nrow(stock)*(2.9/3))

# Apply the ACF and PACF functions
par(mfrow = c(1,1))
acf.stock = acf(stock[c(1:breakpoint),], main='ACF Plot', lag.max=100)
pacf.stock = pacf(stock[c(1:breakpoint),], main='PACF Plot', lag.max=100)


# Initialzing an xts object for Actual log returns
Actual_series = xts(0,as.Date("2014-11-25","%Y-%m-%d"))

# Initialzing a dataframe for the forecasted return series
forecasted_series = data.frame(Forecasted = numeric())

for (b in breakpoint:(nrow(stock)-1)) {
    
    stock_train = stock[1:b, ]
    stock_test = stock[(b+1):nrow(stock), ]
    
    # Summary of the ARIMA model using the determined (p,d,q) parameters
    fit = arima(stock_train, order = c(2, 0, 2),include.mean=FALSE)
    summary(fit)
    
    # plotting a acf plot of the residuals
    acf(fit$residuals,main="Residuals plot")
    
    # Forecasting the log returns
    arima.forecast = forecast(fit, h = 1,level=99)
    summary(arima.forecast)
    
    # plotting the forecast
    par(mfrow=c(1,1))
    plot(arima.forecast, main = "ARIMA Forecast")
    
    # Creating a series of forecasted returns for the forecasted period
    forecasted_series = rbind(forecasted_series,arima.forecast$mean[1])
    colnames(forecasted_series) = c("Forecasted")
    
    # Creating a series of actual returns for the forecasted period
    Actual_return = stock[(b+1),]
    Actual_series = c(Actual_series,xts(Actual_return))
    rm(Actual_return)
    
    print(stock_prices[(b+1),])
    print(stock_prices[(b+2),])
    
}


# Adjust the length of the Actual return series
Actual_series = Actual_series[-1]

# Create a time series object of the forecasted series
forecasted_series = xts(forecasted_series,index(Actual_series))

# Create a plot of the two return series - Actual versus Forecasted
plot(Actual_series,type='l',main='Actual Returns Vs Forecasted Returns')
lines(forecasted_series,lwd=1.5,col='red')
legend('bottomright',c("Actual","Forecasted"),lty=c(1,1),lwd=c(1.5,1.5),col=c('black','red'))

# Create a table for the accuracy of the forecast
comparsion = merge(Actual_series,forecasted_series)
comparsion$Accuracy = sign(comparsion$Actual_series)==sign(comparsion$Forecasted)
print(comparsion)

# Compute the accuracy percentage metric
Accuracy_percentage = sum(comparsion$Accuracy == 1)*100/length(comparsion$Accuracy)
print(Accuracy_percentage)



### - - - - - - - -  - -  - - --- - -  xgb  - - --- - -  - -  - - - - - - - - ###
### - - - - - - - -  - -  - - --- - -  xgb  - - --- - -  - -  - - - - - - - - ###
### - - - - - - - -  - -  - - --- - -  xgb  - - --- - -  - -  - - - - - - - - ###
### - - - - - - - -  - -  - - --- - -  xgb  - - --- - -  - -  - - - - - - - - ###


# Load the relevant libraries
library(quantmod); library(TTR)
library(xgboost);

symbols <- c('TER','SPOT','TWTR')

getSymbols(Symbols = symbols, from = '2010-01-01', auto.assign = TRUE)

TER = na.omit(TER)
df = as.data.frame(TER)

# Read the stock data 
# symbol = "ACC"
# fileName = paste(getwd(),"/",symbol,".csv",sep="") ; 
# df = as.data.frame(read.csv(fileName))
#df$Date = as.Date(rownames(df))
#colnames(df) = c("Date","Time","Close","High", "Low", "Open","Volume")

# Define the technical indicators to build the model 
rsi = RSI(df$TER.Close, n=14, maType="WMA")
adx = as.data.frame(ADX(df)) # <--- !!! Error !!! Cannot ADX(df)
adx = as.data.frame(ADX(df[,c("TER.High","TER.Low","TER.Close")]))
sar = SAR(df[,c("TER.High","TER.Low")], accel = c(0.02, 0.2))
trend = df$TER.Close - sar

# create a lag in the technical indicators to avoid look-ahead bias 
rsi = c(NA,head(rsi,-1)) 
adx$ADX = c(NA,head(adx$ADX,-1)) 
trend = c(NA,head(trend,-1))

# Create the target variable
price = df$TER.Close-df$TER.Open
class = ifelse(price > 0,1,0)


# Create a Matrix
model_df = data.frame(class,rsi,adx$ADX,trend)
model = matrix(c(class,rsi,adx$ADX,trend), nrow=length(class))
model = na.omit(model)
colnames(model) = c("class","rsi","adx","trend")


# Split data into train and test sets 
train_size = 2/3
breakpoint = nrow(model) * train_size

training_data = model[1:breakpoint,]
test_data = model[(breakpoint+1):nrow(model),]


# Split data training and test data into X and Y
X_train = training_data[,2:4] ; Y_train = training_data[,1]
class(X_train)[1]; class(Y_train)

X_test = test_data[,2:4] ; Y_test = test_data[,1]
class(X_test)[1]; class(Y_test)

# Train the xgboost model using the "xgboost" function
dtrain = xgb.DMatrix(data = X_train, label = Y_train)
xgModel = xgboost(data = dtrain, nround = 5, objective = "binary:logistic")


