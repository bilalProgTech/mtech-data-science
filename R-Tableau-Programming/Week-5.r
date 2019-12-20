
library(tidyverse)

data('mtcars')

glimpse(mtcars)

select(mtcars, mpg, cyl)

select(mtcars, -mpg)

filter(mtcars, carb %in% c(1,4))

summarise(mtcars, wtmean=mean(wt), wtmedian=median(wt))

summarise_at(mtcars, vars(hp, wt, qsec), funs(n(),mean, median))

summarise_at(mtcars, vars(hp, wt, qsec), funs(missing=sum(is.na(.))))

summarise_at(mtcars, vars(hp, wt, qsec), funs(missing=sum(!is.na(.))))

summarise_at(mtcars, vars(hp, wt, qsec), function(x)var(x-mean(x)))

summarise_all(mtcars, funs(n(), mean, median))

summarise_if(mtcars, is.numeric, funs(n(), mean, median))

mdata = iris[sapply(iris, is.numeric)]

summarise_all(mdata, funs(n(), mean, median))

arrange(iris, Sepal.Length)

arrange(iris, Sepal.Length, Sepal.Width)

arrange(iris, desc(Sepal.Length), Sepal.Width)

iris %>% select(Sepal.Length, Sepal.Width) %>% sample_n(3)

mtcars %>% group_by(cyl) %>% summarise_at(vars(disp), funs(mean))

mtcars %>% filter(cyl%in% c(4,8)) %>% arrange(desc(disp)) %>% group_by(cyl) %>%do(head(.,2))

mtcars %>% filter(cyl%in% c(4,8)) %>% arrange(desc(disp)) %>% group_by(cyl) %>% filter(min_rank(desc(disp))==1)

min_rank(mtcars$disp)

mtcars %>% select(mpg, cyl) %>% mutate(newvar=mpg*cyl)

mtcars %>% mutate_all(funs('newvar'=.*100))

mtcars %>% mutate_at(vars(mpg,cyl),funs('newvar'=.*100))

df1 = data.frame(ID=c(1,2,3,4,5), w=c('a','b','c','d','e'), x = c(1,1,0,0,1),y = rnorm(5), z = letters[1:5])
df2 = data.frame(ID=c(1,7,3,6,8), w=c('z','b','k','d','l'), x = c(1,2,3,0,4),y = rnorm(5), z = letters[2:6])

inner_join(df1,df2, by='ID')

inner_join(df1,df2, by=c('ID','ID'))

right_join(df1,df2, by='ID')

left_join(df1,df2, by='ID')

df = data.frame(x=c(1:100))

df %>% mutate(evenodd=if_else(x%%2==0,'EVEN','ODD'))

df %>% mutate(pass=case_when(
    x<35~'Fail',
    x>75~'Grade A',
    x>60~'Grade B',
    x>50~'Grade C',
    TRUE~'Pass'
))

mtcars %>% rowwise() %>% mutate(add=sum(cyl, disp,hp)) %>% select(c(cyl, disp, hp, add))

select_if(iris, is.factor)

select_if(iris, is.numeric)

mutate_if(iris, is.numeric, funs('new'=.*100))

newfun = function(x, N=5){
    x %>% arrange(desc(disp)) %>% head(N)
}

mtcars %>% group_by(cyl) %>% do(newfun(.,3))

library(ggplot2)

data()
data(iris)

plot(iris)

plot(iris$Petal.Length, iris$Sepal.Width)

ggplot(iris, aes(x = Petal.Length, y=Sepal.Width)) + geom_point()

ggplot(iris, aes(x = Petal.Length, y=Sepal.Width, col=Species)) + geom_point()

ggplot(iris, aes(x = Petal.Length, y=Sepal.Width, col=Species, 
                 size=Petal.Width)) + geom_point()

ggplot(iris, aes(x = Petal.Length, y=Sepal.Width, col=Species, 
                 size=Petal.Width, shape=Species)) + geom_point()

ggplot(iris, aes(x = Petal.Length, y=Sepal.Width, col=Species, 
                 size=Petal.Width, shape=Species, 
                 alpha=Sepal.Length)) + geom_point()

ggplot(iris, aes(Species, Sepal.Length)) + geom_bar(stat='summary', fun.y='mean')

ggplot(iris, aes(Species, Sepal.Length, 
                 fill=Species)) + geom_bar(stat='summary', fun.y='mean')

ggplot(iris, aes(Species, Sepal.Length))+ geom_bar(stat='summary', 
                                                   fun.y='mean', fill='blue')

ggplot(iris, aes(Species, Sepal.Length))+ geom_bar(stat='summary', 
                                                   fun.y='mean', fill='#ff0080',
                                                  col='black') + geom_point()

myplot = ggplot(iris, aes(Species, Sepal.Length))+ geom_bar(stat='summary', 
                                                   fun.y='mean',
                                                   fill='#ff0080',
                                                  col='black'
                                                  ) + geom_point(
    position = position_jitter(0.2), size=3, shape=21 )

myplot + theme(panel.grid = element_blank(), 
               panel.background = element_rect(fill='blue'), 
               panel.border=element_rect(colour="black", fill=NA, size=0.2))

?theme

myplot + theme_bw()

myplot + theme_dark()

myplot + theme_gray()

myplot + theme_minimal()

myplot + theme_linedraw() + theme( 
               panel.background = element_rect(fill='blue'))

ggplot(iris, aes(Species, Sepal.Length)) + geom_boxplot(fill='blue',col='black')

ggplot(iris, aes(Species, Sepal.Length)) + geom_boxplot(
    fill='blue',col='black', notch=TRUE)

myplot + theme_bw() + 
    labs(x = "", y="Sepal length(nm)") + ggtitle("Sepal length by iris species")+
    theme(plot.title = element_text(hjust=0.5))

#setwd("~/Documents")
ggsave("Graph 1.png", width=8, height=5)
