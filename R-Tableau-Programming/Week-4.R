x = iris
x
y = apply(x[1:4], 1, sum)
y[1:10]
y = tapply(x$Sepal.Length, x$Species, sum)
y

y = lapply(x$Sepal.Length, sum)
y


f = function(){
  print('Hello World')
}

f
f()

f = function(name){
  paste('Hii ',name)
}

f = function(x=1,y){
  return(x/y)
}
f(3,3)
formals(f)
body(f)
environment(f)
x = 1
g = function(){
  y =2
  i = function(){
    z = 3
    c(x,y,z)
  }
  i()
}
g()
fact = function(num){
  if(num==0 || num==1){
    return(1)
  }
  else{
    return(fact(num-1) * num)
  }
}
fact(171)

funs = list(
  half = function(x) x /2,
  double = function(x) x * 2
)
funs[[1]](67)
funs$double(12)
fun = function(...){
  list(...)
}
fun(1,2,3,22,1,3,123,1,3,1,4)


num = 50
guess_number = function(){
  input = as.integer(readline(prompt = "Enter Number: (Guess It): "))
  k = 10
  while(num != input){
    if(input > (num+10)){
      print("Too High Number, guess smaller than this")
    }
    else if(input > num){
      print("High Number. About to guess correctly ")    
    }
    else if(input < (num-10)){
      print("Too Small Number. About to guess correctly ") 
    }
    else if(input < num){
      print("Small Number. guess higher than this ")
    }
    k = k-1
    if(k == 0){
      print("All Attempt Used")
      break
    }
    message(k,' attempts left')
    input = as.integer(readline(prompt = "Again Enter the number: "))
  }
  if(input == num){
    print("Correct Answer")
  }
}
guess_number()
