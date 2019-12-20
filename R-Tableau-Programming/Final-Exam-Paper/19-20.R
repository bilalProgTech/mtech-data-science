library(dplyr)
library(ggplot2)
library(tidyverse)
library(quantmod)
library(xlsx)

# Q.1)

# Ans A)

aritmetic = function(..., operator = "+"){
  temp = 1
  if(operator == "+"){
    return(sum(...))
  }
  else if(operator == '-'){
    for(x in list(...)){
      temp=temp-x
    }
    return(temp)
  }
  else if(operator == '*'){
    for(x in list(...)){
      temp=temp*x
    }
    return(temp)
  }
}

aritmetic(1,2,3,4,5, operator = '-')
aritmetic(1,2,3,4,5)
aritmetic(1,2,3,4,5, operator = '*')

# Ans B)

# i)
popc = read.csv('pop_change.csv', skip = 2, row.names = "STATE_OR_REGION")

# ii)
sum(is.na.data.frame(popc)) > 0

# iii)
popc %>% select(contains("Population"))

# iv)
popc %>% mutate(States = rownames(.)) %>% 
  mutate(percent = ((X2000_POPULATION-X2010_POPULATION)/((X2000_POPULATION+X2010_POPULATION)/2))) %>% 
  filter(percent > 0) %>% select(States) 

# v)
sapply(popc, mean)
popc = rbind(popc, sapply(popc, mean))

# Q.3)

# Ans A)

# i)
iris %>% ggplot(aes(x = Petal.Length, y=Sepal.Width)) + geom_line()

# ii)
iris %>% ggplot(aes(Sepal.Length, Sepal.Width)) + geom_smooth(method="auto", stat="summary")  + 
  labs(x="Sepal Length",y="Sepal Width")

# iii)
iris %>% ggplot(aes(Sepal.Length, Sepal.Width)) + geom_smooth(method="auto", stat="summary") + 
  geom_point() + labs(x="Sepal Length",y="Sepal Width")

# iv)
ggplot(iris, aes(x = Sepal.Length, y=Sepal.Width, col=Species, 
                 size=Sepal.Length, shape=Species, 
                 alpha=Sepal.Length)) + geom_point()

# v)
iris %>% ggplot(aes(x = Sepal.Length, y=Sepal.Width, col=Species, 
                    size=Sepal.Length, shape=Species, 
                    alpha=Sepal.Length)) + 
  geom_point()+
  labs(x="Sepal Length",
       y="Sepal Width",
       subtitle = "Species",
       title = "Scatter Plot",
       caption = "Fig shows Scatter plot for Sepal Width and Length w.r.t. Species")

# vi)
setwd('C:/Users/hungu/Documents/MTech DS Docs/R Programming/')
ggsave("Graph 1.png", width=8, height=5)

# Ans B)

# i)
iris %>% gather(Data, Value, Sepal.Length:Sepal.Width) %>% group_by(Data) %>% summarise_at(vars(Value), funs(mean))

# ii)
iris %>% group_by(Species) %>% summarise_at(vars(Sepal.Width), funs(mean)) %>% top_n(1)

# iii)
iris %>% filter(Sepal.Length>= 4.6 && Sepal.Width >= 0.5) %>% select(starts_with("P"))

# iv)
iris %>% arrange(desc(Petal.Length)) %>% head(10)

# v)
iris %>% select(tail(names(.),2)) %>% slice(tail(row_number(), 2))

# Q.4)

# Ans A)

# i)
sem_1 = data.frame(Semester=c('Sem 1','Sem 1','Sem 1','Sem 1','Sem 1'),
                   Exam = c('R', 'Finance','Marketing','Machine Learning','Python'),
                   Marks = c(70,63,82,63,78))

sem_2 = data.frame(Semester=c('Sem 2','Sem 2','Sem 2','Sem 2','Sem 2'),
                   Exam = c('R', 'Finance','Marketing','Machine Learning','Python'),
                   Marks = c(82,74,64,70,65))

# ii)
merged = rbind(sem_1, sem_2)

# iii)

ggplot(merged, aes(x=Semester, y=Marks)) + 
  geom_bar(stat='summary', fun.y='mean') + 
  labs(x = "Exam", y="Marks Scored") + 
  ggtitle("Chart for Marks in Semester")

# iv)
ggplot(merged, aes(x=Semester, y=Marks, fill=Exam)) + 
  geom_bar(stat='summary', fun.y='mean', position="dodge") + 
  labs(x = "Exam", y="Marks Scored") + 
  ggtitle("Chart for Marks in Exam with Subjects")

# v)
ggplot(merged, aes(x=Semester, y=Marks, fill=Exam)) + 
  geom_bar(stat='summary', fun.y='mean', position="fill") + 
  labs(x = "Exam", y="Marks Scored") + 
  ggtitle("Chart for Marks in Exam with Subjects Stacked")

# Ans B)
isprime = function(n, i=2){
  if(n < 2)
    return(F)
  if(n == 2)
    return(T)
  if(n %% i == 0)
    return(F)
  if(i * i > n)
    return(T)
  
  return(isprime(n, i+1))
}

for(i in 2:20){
  if(isprime(i)){
    print(i)
  }
}

# Q.5)

# Ans A)

# i)
start = as.Date('2018-01-01')
end = as.Date("2019-11-18")

getSymbols(c('MSFT','AAPL','GOOG','TSLA'), from=start)
write.csv(GOOG, 'GOOG.csv')

# ii)
stocks = as.xts(data.frame(AAPL=AAPL[,'AAPL.Close'],TSLA=TSLA[,'TSLA.Close']))
plot(as.zoo(stocks), lty=1:2, xlab='Data', ylab='Price', col=1:2)
legend('right',c('AAPL','TSLA'), lty=1:2, cex=0.5)

# iii)
stocks = as.xts(data.frame(AAPL=AAPL[,'AAPL.Close'], MSFT=MSFT[,'MSFT.Close'], TSLA=TSLA[,'TSLA.Close']))
cor(stocks)

# After observing correlation matrix, it is inferred that, Microsoft and Apple stocks are highly correlated

# iv)
TSLA$diff = diff(TSLA$TSLA.Close)
plot(TSLA$diff, xlab='Data', ylab='Price')

# v)
stocks = as.xts(data.frame(AAPL=AAPL[,'AAPL.Close'], MSFT=MSFT[,'MSFT.Close'],
                           GOOG=GOOG[,'GOOG.Close'], TSLA=TSLA[,'TSLA.Close']))
sapply(stocks, max)
sapply(stocks, min)
sapply(stocks, mean)

# Ans B)

auth = function(){
  pass = 'pass@123'
  
  response = ''
  counter = 3
  while(counter!=0){
    response = readline(prompt = 'Enter Password: ')
    if(response == pass){
      message('Successfully logged in')
      break
    }
    counter = counter - 1
    message((3-counter),' Failed Login. ',counter,' more attempts left')
    if(counter==0) message('You are locked out')
  }
}
auth()

# Q.6)

# Ans A)

# i)

is.na(airquality)
sum(is.na.data.frame(airquality))
airquality %>% summarise_all(funs(sum(is.na(.))))
colSums(is.na(airquality))

# ii)

remove_na = na.omit(airquality)
sum(is.na.data.frame(remove_na))

# iii)

impute_na = airquality
impute_na = impute_na %>% mutate(Ozone= replace(Ozone, is.na(Ozone), mean(Ozone, na.rm=TRUE)))
impute_na = impute_na %>% mutate(Solar.R= replace(Solar.R, is.na(Solar.R), mean(Solar.R, na.rm=TRUE)))
sum(is.na.data.frame(impute_na))

# iv)
impute_na %>% select(Ozone, Month) %>% filter(Month == 5) %>% 
  ggplot(aes(x=Month, y=Ozone)) + geom_line() + geom_point()

# Ans B)

# i)
na_adjacent = function(col){
  missing_index = which(is.na(col))
  print(missing_index)
  temp = missing_index
  t = 1
  nextna = 0
  for(i in missing_index){
    if(nextna == 1){
      col[i] = col[i-1]
      nextna = 0
    }
    else{
      col[i] = ceiling((col[i-1]+col[i-2])/2)
    }
    if(temp[t+1]-temp[t] == 1){
      nextna = 1
    }
    t = t + 1
    if(t == length(temp))
      t = 1
  }
  return(col)
}

airquality$Ozone = na_adjacent(airquality$Ozone)
airquality$Solar.R = na_adjacent(airquality$Solar.R)


# ii)

airquality %>% group_by(Month) %>% summarise_at(vars(Ozone), funs(avg = mean(.,na.rm=T))) %>% top_n(1)
