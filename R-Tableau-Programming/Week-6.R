library(ggplot2)
titanic = read.csv("titanic.csv", stringsAsFactors = F)
View(titanic)

titanic$Pclass = as.factor(titanic$Pclass)
titanic$Survived = as.factor(titanic$Survived)
titanic$Sex = as.factor(titanic$Sex)
titanic$Embarked = as.factor(titanic$Embarked)

ggplot(titanic, aes(x=Survived)) + geom_bar()

prop.table(table(titanic$Survived))

summary(titanic$Survived)
table(titanic$Survived) # specific for factors

ggplot(titanic, aes(x=Survived)) +
  theme_bw() + geom_bar() + labs(y = "Passenger Count",
                                 title="Titanic Survival Rate")
ggplot(titanic, aes(x=Sex, fill=Survived)) +
  theme_bw() + geom_bar() + labs(y = "Passenger Count",
                                 title="Titanic Survival Rate by Sex")

ggplot(titanic, aes(x=Sex, fill=Pclass)) +
  theme_bw() + geom_bar() + labs(y = "Passenger Count",
                                 title="Titanic Pclass Rate by Sex")

ggplot(titanic, aes(x=Pclass, fill=Survived)) +
  theme_bw() + geom_bar() + labs(y = "Passenger Count",
                                 title="Titanic Pclass Rate by Sex")

ggplot(titanic, aes(x=Sex, fill=Survived)) +
  theme_bw() + facet_wrap(~ Pclass) + 
  geom_bar() + labs(y = "Passenger Count",
                                 title="Titanic Survived Rate by Sex")

ggplot(titanic, aes(x=Age)) +
  theme_bw() +
  geom_histogram(binwidth = 5) + labs(y = "Passenger Count",
                                      x = "Age (Binwidth=5)",
                    title="Titanic Age Distribution")

ggplot(titanic, aes(x=Age, fill=Survived)) +
  theme_bw() +
  geom_histogram(binwidth = 5) + labs(y = "Passenger Count",
                                      x = "Age (Binwidth=5)",
                                      title="Titanic Age Distribution")

ggplot(titanic, aes(x=Survived, y=Age)) +
  theme_bw() +
  geom_boxplot() + labs(y = "Age Dist",
                                      x = "Survived",
                                      title="Titanic Age Distribution")

ggplot(titanic, aes(x=Age, fill=Survived)) +
  theme_bw() + facet_wrap(Sex ~ Pclass) +
  geom_density(alpha = 0.5) + labs(y = "Age Dist",
                        x = "Survived",
                        title="Titanic Survived rate by Age, Pclass, and Sex")

ggplot(titanic, aes(x=Age, fill=Survived)) +
  theme_bw() + facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 5) + labs(x = "Age",
                                title="Titanic Survived rate by Age, Pclass, and Sex")

#-------------------------------------------------------------------------------------#

install.packages("quantmod")
install.packages("xlsxjars")

library(quantmod)
library(xlsx)

start = as.Date('2018-01-01')
end = as.Date("2018-08-31")

getSymbols("AAPL",src="yahoo", from=start, to=end)
plot(AAPL[, 'AAPL.Close'],main="Apple")

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

index(MSFT)

MSFT$Date = as.character(index(MSFT))
write.csv(MSFT, '123.csv')

