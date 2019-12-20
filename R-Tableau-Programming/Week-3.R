ages = 16 + 50 * rbeta(1000,2,3)
ages
seq.int(16,66,10)
?rbeta()

group_age = cut(ages, seq.int(16,66,10))
group_age
table(group_age)

class(group_age)

if(T) message('It is true')
if(F) message('It is false')

if(runif(1)>0.5) message('Chance of 50%')

x = 3
if(x >3){
  message(3*10)
}else if(x>1){
  message(2*10)  
}else{
  message(x^2)
}

b = c(1,2,3,4,5)
ifelse(b>2, b*10, b^2)

ifelse(x>2, x*10, x^2)

name = readline(prompt="Your Name:")
message('Hi ', name)


year = 2016
if(year%%4==0){
  if(year%%100==0){
    if(year%%400==0){
      message("Leap Year")
    }else{
      message('Not Leap year')
    }
  }else{
    message("Leap Year")
  }
}else{
  message("Not Leap year")
}


  
lang = 'Mandarin'
switch(lang,
       'English'= 'Hello',
       'Hindi'='Namaste',
       'Spanish'='Hola',
       'Mandarin' = 'Ni Hao',
       'Sorry Language not supported'
       )

switch(2,
       'English'= 'Hello',
       'Hindi'='Namaste',
       'Spanish'='Hola',
       'Mandarin' = 'Ni Hao',
       'Sorry Language not supported'
)


x = 1
repeat{
  message(x)
  x = x+1
  if(x==6){
    break
  }
}

x = 1
while(x <6){
  message(x)
  x = x+1
}

for(i in 1:5) message(i)

pass = 'pass@123'

response = ''

while(response!=pass){
  response = readline(prompt = 'Enter Password: ')
  if(response == pass){
    message('Successfully logged in')
    break
  }
  message('Wrong password, do you want to see you password')
  r = readline(prompt='yes/no?: ')
  if(r=='yes' | r=='y') message("Your password is: ",pass)
}

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
  message(counter,' attempts left')
  if(counter==0) message('You are locked out')
}

