data = read.csv("Advertising.csv")

data$TV = scale(data$TV)
data$radio = scale(data$radio)
data$newspaper = scale(data$newspaper)

Y = data$sales
alpha <- 0.01
iter = 2000
hist_theta = list(iter)
theta <- matrix(c(0,0,0,0),nrow = 4)


X = cbind(1,matrix(data$TV),matrix(data$radio),matrix(data$newspaper))

for(i in 1:iter){
  htheta <- X %*% theta
  
  diffHtheta <- htheta- Y
  
  p.d.jtheta <- t(X) %*% diffHtheta / length(Y)
  
  theta <- theta - alpha * p.d.jtheta
  hist_theta[[i]] = theta
}
hist_theta[1999]
