library(quantmod)
quantmod::c
#Create an array 'symbols' to reference desired ts data
# 
#


#Core symbol array
symbols <- c('XLE','XOM','DJIA','GE')

getSymbols(symbols)

# OCT2015 Mutual Funds <~>
#BSCFX,FBIOX,HLEMX,POGRX
###
library(quantmod)
symbols <- c('BSCFX','FBIOX','HLEMX','POGRX')
getSymbols(symbols)


#Multicharting
par(mfrow=c(2,1))
plot()

# OCT2015 Mutual Funds <~>
#

###________________________________
# ARKW <- ETF investing in BitCoins
# MMJ Stocks <- 'TRTC','CNAB', 'GWPH'
# MMJ Descr <- ('TerraTech','United C Corp','GW Pharmaceuticals')
symbols <- c('INTC','XLE','HACK','DJIA','FRO','GE','MMM','BA','ARKW','TRTC')
getSymbols(symbols)

#Create indicator variable
indicators <- c(addVo(),addBBands(),addRSI(),addMACD(slow=30,fast=16))

#High of observation minus minimum Low of Series
Hi(DJIA)-min(Lo(DJIA))

#High minus Low over Close minus Open
(Hi(DJIA)-Lo(DJIA))/(Cl(DJIA)-Op(DJIA))

#(Close minus High)/Close 
##provides a derived indicator that measures the distance between the Highest Price and the Closing Price as a percentage of the Close
HCL_DJIA <- (Hi(DJIA)-Cl(DJIA))/(Cl(DJIA))


#Basic Charting

#DJIA last 2 years weekly 
chartSeries(to.weekly(DJIA),type='matchsticks',subset='last 24 months',TA=c(addVo(),addBBands(),addRSI(),addMACD(slow=16,fast=8)))

#DJIA last 6 months daily
chartSeries(to.daily(DJIA),type='candlesticks',subset='last 6 months',TA=c(addVo(),addBBands(),addRSI(),addMACD(slow=16,fast=8)))

candleChart(DJIA,multi.col=TRUE,theme='beige',subset='last 5 months')
addBBands(slow=10,fast=5)

#................................................................#
#Candle chart with parameters ##Beige and White themes#
##
#................................................................#


par(mfrow=c(2,2))
candleChart(DJIA,multi.col=TRUE,theme='beige',subset='2007-12::2008')

candleChart(to.monthly(DJIA),multi.col=TRUE,theme='white',type='candles',subset='2010-01::2015')

candleChart(to.daily(DJIA),type='candlesticks',subset='last 6 months',TA=c(addVo(),addBBands(),addRSI(),addMACD(slow=16,fast=8)),theme='beige')

candleChart(to.daily(DJIA),type='candlesticks',subset='last 6 months',TA=c(addVo(),addBBands(),addRSI(),addMACD(slow=24,fast=8)),theme='beige')


##For loop multicharting.........................................#

library(quantmod)
getSymbols("DJIA")

op <- par(mfrow=c(4,3))
for(i in length(symbols)) {
  chartSeries(
    symbols[i], "candlesticks", 
    TA=NULL, # No volume plot
    layout=NULL
  )
}
par(op)

