from sklearn.preprocessing import scale
import numpy as np
class GradientDescent:
    
    learning_rate = 0.01
    max_iter = 2000
    scale = False
    new_theta = []
    
    def __init__(self, learning_rate=0.01, max_iter=2000, scale=False):
        self.learning_rate = learning_rate
        self.max_iter = max_iter
        self.scale = scale
        
    def fit(self, X, y):
        ones = [1] * len(X)
        if self.scale:
            X = scale(X)
        X = np.transpose(np.concatenate((np.array([ones]).reshape(-1, 1), X), axis=1))
        zeroes = [0] * X.shape[0]
        theta = np.array([zeroes])
        for i in range(self.max_iter):
            htheta = np.dot(theta, X)
            diff_theta = htheta - y.values
            partial_derivative_theta = np.dot(diff_theta, np.transpose(X)) / len(y.values)
            theta = theta - self.learning_rate * partial_derivative_theta
            self.new_theta.append(theta)
    
    def predict(self, X):
        if scale:
            X = scale(X)
        theta0 = self.new_theta[self.max_iter-1][0][0]
        thetas = []
        for i in range(1, self.new_theta[self.max_iter-1].shape[1]):
            thetas.append(self.new_theta[self.max_iter-1][0][i])
        predict = theta0 + (thetas * X).sum(axis=1)
        return(predict)
    
    def score(self, X, y):
        if scale:
            X = scale(X)
        pred_y = self.predict(X)
        mean_y = y.mean()
        ess = sum((y - mean_y) ** 2)
        rss = sum((y - pred_y) ** 2)
        rsquared = 1 - (rss/ess)
        return rsquared