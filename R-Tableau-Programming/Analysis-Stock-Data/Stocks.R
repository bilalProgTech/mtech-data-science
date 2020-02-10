library(quantmod)
library(xlsx)

# Initializing starting date an end date till that stocks will be fetched
start = as.Date('2018-01-01')
end = as.Date("2018-08-31")

# Getting Symbolic Representation of Apple Stock
getSymbols("AAPL",src="yahoo", from=start, to=end)

#Ploting graph for Apple Stocks
plot(AAPL[, 'AAPL.Close'],main="Apple")

# Ploting Candle Charts for Apple Stocks
candleChart(AAPL, up.col="green", dn.col="red", theme="white")

getSymbols(c('MSFT','AAPL','GOOG','TSLA'), from=start)

stocks = as.xts(data.frame(AAPL=AAPL[,'AAPL.Close'], MSFT=MSFT[,'MSFT.Close'],
                           GOOG=GOOG[,'GOOG.Close'], TSLA=TSLA[,'TSLA.Close']))
plot(as.zoo(stocks), screen=1, lty=1:4, xlab='Data', ylab='Price', col=1:4)
plot(as.zoo(stocks), lty=1:4, xlab='Data', ylab='Price', col=1:4)
legend('right',c('AAPL','MSFT','GOOG','TSLA'), lty=1:4, cex=0.5)

par(new=T)
par(mfrow=c(1,1))

a = allReturns(GOOG)
GOOG$diff = diff(GOOG$GOOG.Close)
q1 = index(stocks[which.max(stocks$MSFT.Close)])

cor(stocks)