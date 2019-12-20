grades = c(1,2,3,3,2,1,3,3,3,2,1,1)
info = data.frame(grade=3:1, rank=c('Excellent','Good','Poor'), fail = c(F,F,T))
info
id = match(grades,info$grade)
id
info[id,]
info[1, ]
info[match(grades, info$grade),c('fail','rank')]
a = c('Jack','Jill','Iron')
'Alex'%in% a
getwd()
setwd()
data("mtcars")
df = mtcars
df
View(df)
df$mpg
df[[1]]
df[1]
df[1:4,4]
df[1:4,4,drop=F]
df[-1]
df[c('Mazda RX4','Valiant'),]
df$new  = 1:32
df$new = NULL
a = df[df$cyl==6,]
View(a)
df[((df$cyl==6)&(df$hp>120)),]
df[((df$cyl==6)&(df$hp>120)),'wt',drop=F]
df[((df$cyl%in%c(6,4))&(df$hp>120)),]
a = df[((df$cyl%in%c(6,4))|(df$hp>120)),]
View(a)
x = 1:10
any(x>8)
all(x>1)
x>8
letters
df1 = data.frame(z = rlnorm(10),
                 y = sample(10),
                 x = letters[3:7])
df1
df2 = data.frame(z = rlnorm(10),
                 y = sample(10),
                 x = letters[3:12])
df2
?rbind
rbind(df1, df2)
cbind(df1,df2)
merge(df1, df2, by='x', all=T)
merge(df1, df2, by='x', all.x=T)
merge(df1, df2, by='x', all.y=T)

colSums(df1[1:2])
colMeans(df1[1:2])
("'They said, Hi'")
('"They said, Hi"')
a = ('"They said, Hi"') 
a
paste('Hello','World')
paste('Hello','World', sep="|")
paste(c('Hello','Hi'), 'world')
paste(c('Hello','Hi'), 'world', sep='-')
paste(c('Hello','Hi'), 'world', collapse = '--')
paste0(c('Hello','Hi'), 'world')

x = (1:15)^2
toString(x)
toString(x, width=40)
cat(c('Hello','Hi'), 'world')
noquote(c('hello','world'))

a = exp(1:3)
a
typeof(a)
format(a, digit=7)

sprintf('%s %d = %f', 'The value for ',1:3,a)
sprintf('%s %d = %0.6f', 'The value for ',1:3,a)

a = c('This is a string',
      'More string, another line',
      'Third Line',
      'End')

substring(a, 2, 6)
substring(a, 1:4, 6)
substring(a, 1:4, 6:9)


strsplit(a,' ,? ')












