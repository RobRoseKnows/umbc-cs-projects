require(ISLR)
require(MASS)
require(boot)

set.seed(1)
train = sample(10000,5000)
train.data = Default[train,]
test.data = Default[-train,]
glm.fit=glm(default ~ income + balance, data=Default, family=binomial, subset=train)
glm.probs=predict(glm.fit, newdata=test, type='response')
mean(glm.probs)
glm.pred=ifelse(glm.probs>.45, "Yes", "No")
table(glm.pred, test.data$default)
