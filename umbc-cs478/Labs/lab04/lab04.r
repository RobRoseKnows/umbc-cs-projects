require(ISLR)
plot(Weekly)
summary(Weekly)

glm(Direction ~ .,data=Weekly, family=binomial)
summary(glm.fit)