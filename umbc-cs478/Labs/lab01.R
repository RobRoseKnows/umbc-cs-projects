### Exercise 1
D = matrix(seq(1,16), 4, 4)
D
C=D[c(2,4), c(2,4)]
C


### Exercise 2
?persp

x = seq(-5, 5, 0.1)
y = seq(-5, 5, 0.1)

fa = function(x, y) cos(x^2 + y^2)/(x^2 +y^2+1)

z = outer(x, y, fa)

?outer
# outer - creates matrix of z values with x, y vectors
#         as axes and filled with function result

persp(x, y, z) #takes x, y, and matrix and plots


### Exercise 3
x = rnorm(9)
A = matrix(x, 3, 3)
A
?matrix

eigenA = eigen(A)
evecA = eigenA$vectors
evecA
evalA = eigenA$values
evalA

evalA[1]%*%evecA[,1]
A %*% evecA[,1]

### Exercise 4
College = read.csv("C:\\Users\\rushm\\Documents\\478\\College.csv")
dim(College)
#is.na(College)
College2 = na.omit(College)
dim(College2)

rownames(College) = College[, 1]
fix(College)

College = College[, -1]
fix(College)

summary(College)
names(College)

#Avg percentage of PhDs on faculty?
summary(College$PhD)
#Avg cost of books?
summary(College$Books)
#Max expenditure per student?
summary(College$Expend)

### Exercise 5
attach(College)
pairs(~Top10perc + Top25perc + PhD + S.F.Ratio + Expend + Grad.Rate)


### Exercise 6
summary(Grad.Rate)
hist(Grad.Rate)

### Exercise 7
sum(College[,"Top10perc"] > 50)


