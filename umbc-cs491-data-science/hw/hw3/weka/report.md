# Homework 3 & 4

Robert Rose

## Part 1: Weka

In this part I will use the datascience tool Weka to analyze three datasets in
classification, regression and clustering taken from the UCI ML data repository.

### Classification

The classificiation dataset I've chosen to use is the [credit approval dataset][credit-ds]
with binary classes (approved or not approved), six continuous variables and nine
categorical variables.

[credit-ds]: http://archive.ics.uci.edu/ml/datasets/credit+approval

#### Random Forest

The first algorithm I applied to the credit approval dataset was a random forest
and it perfromed rather well. The output of the classifier is below but the summary
statistic of F-Measure resulted int 0.867, rather good for a simple classifier.

```
=== Run information ===

Scheme:       weka.classifiers.trees.RandomForest -P 100 -I 100 -num-slots 1 -K 0 -M 1.0 -V 0.001 -S 1
Relation:     classification
Instances:    690
Attributes:   16
              A01
              A02
              A03
              A04
              A05
              A06
              A07
              A08
              A09
              A10
              A11
              A12
              A13
              A14
              A15
              A16
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===

RandomForest

Bagging with 100 iterations and base learner

weka.classifiers.trees.RandomTree -K 0 -M 1.0 -V 0.001 -S 1 -do-not-check-capabilities

Time taken to build model: 0.22 seconds

=== Stratified cross-validation ===
=== Summary ===

Correctly Classified Instances         598               86.6667 %
Incorrectly Classified Instances        92               13.3333 %
Kappa statistic                          0.7295
Mean absolute error                      0.2294
Root mean squared error                  0.3216
Relative absolute error                 46.4412 %
Root relative squared error             64.706  %
Total Number of Instances              690     

=== Detailed Accuracy By Class ===

                 TP Rate  FP Rate  Precision  Recall   F-Measure  MCC      ROC Area  PRC Area  Class
                 0.840    0.112    0.857      0.840    0.849      0.730    0.926     0.904     +
                 0.888    0.160    0.874      0.888    0.881      0.730    0.926     0.922     -
Weighted Avg.    0.867    0.139    0.867      0.867    0.867      0.730    0.926     0.914     

=== Confusion Matrix ===

   a   b   <-- classified as
 258  49 |   a = +
  43 340 |   b = -
```

#### Naive Bayes

The second algorithm I tried on the data was Naive Bayes, and I expected it to do
somewhat worse than the Random Forest. My suspicion was correct and it had an
F-measure of 0.769, almost exactly 0.1 less than Random Forests.

```
=== Run information ===

Scheme:       weka.classifiers.bayes.NaiveBayes 
Relation:     classification
Instances:    690
Attributes:   16
              A01
              A02
              A03
              A04
              A05
              A06
              A07
              A08
              A09
              A10
              A11
              A12
              A13
              A14
              A15
              A16
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===

Naive Bayes Classifier

                   Class
Attribute              +         -
                  (0.45)    (0.55)
===================================
A01
  b                 207.0     263.0
  a                  99.0     113.0
  [total]           306.0     376.0

A02
  mean             33.723   29.8068
  std. dev.       12.7816   10.9057
  weight sum          305       373
  precision        0.1911    0.1911

A03
  mean             5.9075    3.8409
  std. dev.        5.4649    4.3316
  weight sum          307       383
  precision        0.1308    0.1308

A04
  u                 257.0     264.0
  y                  46.0     119.0
  l                   3.0       1.0
  [total]           306.0     384.0

A05
  g                 257.0     264.0
  p                  46.0     119.0
  gg                  3.0       1.0
  [total]           306.0     384.0

A06
  w                  34.0      32.0
  q                  52.0      28.0
  m                  17.0      23.0
  r                   3.0       2.0
  cc                 30.0      13.0
  k                  15.0      38.0
  c                  63.0      76.0
  d                   8.0      24.0
  x                  33.0       7.0
  i                  15.0      46.0
  e                  15.0      12.0
  aa                 20.0      36.0
  ff                  8.0      47.0
  j                   4.0       8.0
  [total]           317.0     392.0

A07
  v                 170.0     231.0
  h                  88.0      52.0
  bb                 26.0      35.0
  ff                  9.0      50.0
  j                   4.0       6.0
  z                   7.0       3.0
  o                   2.0       2.0
  dd                  3.0       5.0
  n                   3.0       3.0
  [total]           312.0     387.0

A08
  mean             3.4242    1.2525
  std. dev.        4.1179    2.1128
  weight sum          307       383
  precision        0.2176    0.2176

A09
  t                 285.0      78.0
  f                  24.0     307.0
  [total]           309.0     385.0

A10
  t                 210.0      87.0
  f                  99.0     298.0
  [total]           309.0     385.0

A11
  mean             4.6823    0.6043
  std. dev.        6.5274    1.9863
  weight sum          307       383
  precision        3.0455    3.0455

A12
  f                 162.0     214.0
  t                 147.0     171.0
  [total]           309.0     385.0

A13
  g                 288.0     339.0
  s                  16.0      43.0
  p                   6.0       4.0
  [total]           310.0     386.0

A14
  mean           164.1864  199.7986
  std. dev.      161.3686  181.3128
  weight sum          301       376
  precision       11.8343   11.8343

A15
  mean          2027.9939  186.8097
  std. dev.      7655.808  675.6316
  weight sum          307       383
  precision        418.41    418.41



Time taken to build model: 0.01 seconds

=== Stratified cross-validation ===
=== Summary ===

Correctly Classified Instances         536               77.6812 %
Incorrectly Classified Instances       154               22.3188 %
Kappa statistic                          0.534 
Mean absolute error                      0.2228
Root mean squared error                  0.4355
Relative absolute error                 45.0957 %
Root relative squared error             87.6395 %
Total Number of Instances              690     

=== Detailed Accuracy By Class ===

                 TP Rate  FP Rate  Precision  Recall   F-Measure  MCC      ROC Area  PRC Area  Class
                 0.596    0.078    0.859      0.596    0.704      0.557    0.896     0.861     +
                 0.922    0.404    0.740      0.922    0.821      0.557    0.896     0.906     -
Weighted Avg.    0.777    0.259    0.793      0.777    0.769      0.557    0.896     0.886     

=== Confusion Matrix ===

   a   b   <-- classified as
 183 124 |   a = +
  30 353 |   b = -
```

#### JRip

For the final classifier I wanted to use something that I was unfamiliar with,
as I've worked with naive bayes and random forests before in previous classes
and extra curiculars. So I chose one of the "rules" classifiers named JRip and
was surprised to find that it classified the classes rather well. It ended up
with an F-Measure of 0.858, beating navie bayes and nearly doing as well as the
random forest classifier. 

```
=== Run information ===

Scheme:       weka.classifiers.rules.JRip -F 3 -N 2.0 -O 2 -S 1
Relation:     classification
Instances:    690
Attributes:   16
              A01
              A02
              A03
              A04
              A05
              A06
              A07
              A08
              A09
              A10
              A11
              A12
              A13
              A14
              A15
              A16
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===

JRIP rules:
===========

(A09 = t) and (A15 >= 234) => A16=+ (157.0/7.0)
(A09 = t) and (A10 = t) => A16=+ (99.0/18.0)
(A09 = t) and (A14 <= 110) and (A15 <= 0) => A16=+ (31.0/5.0)
 => A16=- (403.0/50.0)

Number of Rules : 4


Time taken to build model: 0.07 seconds

=== Stratified cross-validation ===
=== Summary ===

Correctly Classified Instances         592               85.7971 %
Incorrectly Classified Instances        98               14.2029 %
Kappa statistic                          0.7136
Mean absolute error                      0.2145
Root mean squared error                  0.345 
Relative absolute error                 43.4166 %
Root relative squared error             69.4163 %
Total Number of Instances              690     

=== Detailed Accuracy By Class ===

                 TP Rate  FP Rate  Precision  Recall   F-Measure  MCC      ROC Area  PRC Area  Class
                 0.860    0.144    0.828      0.860    0.843      0.714    0.874     0.845     +
                 0.856    0.140    0.884      0.856    0.870      0.714    0.874     0.857     -
Weighted Avg.    0.858    0.142    0.859      0.858    0.858      0.714    0.874     0.852     

=== Confusion Matrix ===

   a   b   <-- classified as
 264  43 |   a = +
  55 328 |   b = -
```

### Regression

For regression experimentation, I chose the [Forest Fires][forest-fires] dataset.
This dataset consisted of 13 attributes consisting of data related to an area
burned by a forest fire and the area burned in hectaacres. In the description of
the dataset, the poster said the output variable is very skewed towards 0.0, and
suggested using a logarithmic transform on the area. I thought that would be prudent
so I did so using the transform below:

`weka.filters.unsupervised.attribute.NumericTransform -R first-last -C java.lang.Math -M log`

Unfortunately that transform also wiped out half the data that was just zeros, so I
undid it.

[forest-fires]: http://archive.ics.uci.edu/ml/datasets/Forest+Fires

#### Linear Regression

The first method I used was simple linear regression which turned out rather poorly,
as I expected it would. The result was a root relative squared error of around 100%,
pretty poor if you ask me. The result of the run is below.

```
=== Run information ===

Scheme:       weka.classifiers.functions.LinearRegression -S 0 -R 1.0E-8 -num-decimal-places 4
Relation:     regression
Instances:    517
Attributes:   13
              X
              Y
              month
              day
              FFMC
              DMC
              DC
              ISI
              temp
              RH
              wind
              rain
              area
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===


Linear Regression Model

area =

      2.0897 * X +
     51.1801 * month=oct,apr,aug,dec,jul,sep,may +
    -48.6144 * month=apr,aug,dec,jul,sep,may +
     31.6394 * month=aug,dec,jul,sep,may +
    -14.2996 * month=jul,sep,may +
     35.6828 * month=sep,may +
     13.67   * day=sat +
      0.1548 * DMC +
     -0.0987 * DC +
      1.237  * temp +
    -19.8389

Time taken to build model: 0.11 seconds

=== Cross-validation ===
=== Summary ===

Correlation coefficient                  0.0763
Mean absolute error                     20.0857
Root mean squared error                 63.8429
Relative absolute error                108.035  %
Root relative squared error            100.2281 %
Total Number of Instances              517     
```

#### Random Forest

I expected Random Forests to do better than plain old linear regression but that
was actually not the case. Random Forests ended up with a smaller correlation
coefficient and a higher root relative squared error. The output of that run can
be seen below.

```
=== Run information ===

Scheme:       weka.classifiers.trees.RandomForest -P 100 -I 100 -num-slots 1 -K 0 -M 1.0 -V 0.001 -S 1
Relation:     regression
Instances:    517
Attributes:   13
              X
              Y
              month
              day
              FFMC
              DMC
              DC
              ISI
              temp
              RH
              wind
              rain
              area
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===

RandomForest

Bagging with 100 iterations and base learner

weka.classifiers.trees.RandomTree -K 0 -M 1.0 -V 0.001 -S 1 -do-not-check-capabilities

Time taken to build model: 0.07 seconds

=== Cross-validation ===
=== Summary ===

Correlation coefficient                  0.0685
Mean absolute error                     21.6386
Root mean squared error                 67.0068
Relative absolute error                116.3877 %
Root relative squared error            105.1951 %
Total Number of Instances              517     
```

#### Gaussian Processes with Normalized Poly Kernel

For the final test, I wanted to try something a little more complicated so I
chose the GaussianProcesses classifier with a Normalized Polynomial Kernel. It
performed the best out of all of the attempts but not by much, with a Root Relative
Squared Error of only slightly less than the others.

```
=== Run information ===

Scheme:       weka.classifiers.functions.GaussianProcesses -L 1.0 -N 0 -K "weka.classifiers.functions.supportVector.NormalizedPolyKernel -E 2.0 -C 250007" -S 1
Relation:     regression
Instances:    517
Attributes:   13
              X
              Y
              month
              day
              FFMC
              DMC
              DC
              ISI
              temp
              RH
              wind
              rain
              area
Test mode:    10-fold cross-validation

=== Classifier model (full training set) ===

Gaussian Processes

Kernel used:
  Normalized Poly Kernel: K(x,y) = <x,y>^2.0/(<x,x>^2.0*<y,y>^2.0)^(1/2)

All values shown based on: Normalize training data

Average Target Value : 0.011777430301082182
Inverted Covariance Matrix:
    Lowest Value = -0.21663787790189823
    Highest Value = 0.9694849098401233
Inverted Covariance Matrix * Target-value Vector:
    Lowest Value = -0.060538519454774654
    Highest Value = 0.9409126995790923
 


Time taken to build model: 0.16 seconds

=== Cross-validation ===
=== Summary ===

Correlation coefficient                  0.051 
Mean absolute error                     19.7883
Root mean squared error                 64.2566
Relative absolute error                106.4352 %
Root relative squared error            100.8775 %
Total Number of Instances              517     
```

### Clustering

For the clustering 