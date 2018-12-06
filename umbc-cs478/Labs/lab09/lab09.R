library(e1071)
library(randomForest)
library(gbm)

train.csv = read.csv(file = "C:\\Users\\Robert\\Documents\\Dev\\umbc-cs-repo\\umbc-cs478\\Labs\\lab09\\path_data_all_processed.csv")
test.csv = read.csv(file = "C:\\Users\\Robert\\Documents\\Dev\\umbc-cs-repo\\umbc-cs478\\Labs\\lab09\\test_path_data_processed.csv")

train.data = train.csv[-1]
test.data = test.csv[-1]

boost.train = train.data
boost.test = test.data

train.data$close = as.factor(train.data$close)
test.data$close = as.factor(test.data$close)

svm.fit1 = svm(close ~ ., data = train.data, kernel="linear", cost=5)
preds = predict(object=svm.fit1, newdata=test.data)
tab = table(preds, test.data$close)
tab
#misclass
1-sum(diag(tab))/sum(tab)
#correct
sum(diag(tab))/sum(tab)


svm.fit2 = svm(close ~ ., data = train.data, kernel="radial", cost=5)
preds = predict(object=svm.fit2, newdata=test.data)
tab = table(preds, test.data$close)
tab
#misclass
1-sum(diag(tab))/sum(tab)
#correct
sum(diag(tab))/sum(tab)

set.seed(1)
# Tree based model
# Random forest
this.forest = randomForest(close ~ ., data=train.data)
this.forest
varImpPlot(this.forest)

new.forest = randomForest(close ~ S2+ S11+ S5+ S2S+ S1, data=train.data)
new.forest
varImpPlot(new.forest)

boost.close = gbm(close ~ ., data=boost.train, distribution = "bernoulli", n.trees = 1000, interaction.depth = 1)
summary(boost.close)
yhat.boost = predict(boost.close, newdata=boost.test, type = "response", n.trees = 50)
yhat.boost
mean((yhat.boost - boost.test$close)^2)
