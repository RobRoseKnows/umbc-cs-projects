require(ISLR)
attach(College)
library(leaps)

# Split into training and test set
set.seed(100)
train_ind=sample(nrow(College), 500)

train=College[train_ind,]
test=College[-train_ind,]

regfit.fwd = regsubsets(Outstate~.,data=train, nvmax=17, method="forward")
summary(regfit.fwd)
regfit.summary=summary(regfit.fwd)

par(mfrow=c(2,2))
# Look at the bic
plot(regfit.summary$bic, xlab="Number of Variables", ylab="BIC", type="l")
which.min(regfit.summary$bic)
points(13, regfit.summary$bic[13], col="red", cex=2, pch=20)

# Look at the adjusted r squared
plot(regfit.summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq", type="l")
which.max(regfit.summary$adjr2)
points(15,regfit.summary$adjr2[15], col="red", cex=2, pch=20)

# Look at the cp 
plot(regfit.summary$cp, xlab="Number of Variables", ylab="Cp", type="l")
which.min(regfit.summary$cp)
points(14, regfit.summary$cp[14], col="red", cex=2, pch=20)

# Look at the adjusted r squared
plot(regfit.summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq", type="l")
which.max(regfit.summary$adjr2)
points(15,regfit.summary$adjr2[15], col="red", cex=2, pch=20)

# Get the coeficients
coef(regfit.fwd, 12)

library(splines)
# Smoothing splines
fit=smooth.spline(Outstate,df=16)


