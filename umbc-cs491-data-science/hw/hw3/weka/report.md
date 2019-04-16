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

For the clustering data set, I chose the [Travel Reviews][travel-reviews] Data 
Set, which contains various reviews in 10 categories, art galleries, dance clubs, 
juice bars, restaurants, museums, resorts, parks/picnic spots, beaches, theaters 
and religious institutions.

[travel-reviews]: http://archive.ics.uci.edu/ml/datasets/Travel+Reviews

#### Canopy

Since I didn't know how many clusters I would find, I first needed to use a
clustering algorithm that didn't require a number of clusters to process.
So I chose Canopy clustering because it was fast and didn't require any initial
cluster sizes. It found six canopies or cluster centers.

```
=== Run information ===

Scheme:       weka.clusterers.Canopy -N -1 -max-candidates 100 -periodic-pruning 10000 -min-density 2.0 -t2 -1.0 -t1 -1.25 -S 1
Relation:     clustering-weka.filters.unsupervised.attribute.Remove-R1
Instances:    980
Attributes:   10
              Category 1
              Category 2
              Category 3
              Category 4
              Category 5
              Category 6
              Category 7
              Category 8
              Category 9
              Category 10
Test mode:    evaluate on training data


=== Clustering model (full training set) ===


Canopy clustering
=================

Number of canopies (cluster centers) found: 6
T2 radius: 0.866     
T1 radius: 1.082     

Cluster 0: 0.88693,1.286835,0.651867,0.466266,0.796551,1.629589,3.177247,2.836044,1.587658,2.951392,{632} <0,1,2,3,4,5>
Cluster 1: 0.88456,1.462013,1.775472,0.607547,1.217421,2.263491,3.188302,2.822736,1.533333,2.508491,{318} <0,1,2,3,4,5>
Cluster 2: 0.982,1.197333,0.344,0.71,1.152,1.966,3.178667,3.101333,1.734667,2.706667,{15} <0,1,2,3,4,5>
Cluster 3: 1.616667,0.466667,0.45,0.413333,0.44,0.886667,3.18,2.95,1.183333,2.533333,{3} <0,1,2,3,4,5>
Cluster 4: 0.88,3.04,0.4725,1.115,1.095,2.23,3.18,2.805,1.3425,2.635,{4} <0,1,2,3,4,5>
Cluster 5: 0.906,2.136,0.456,2.456,0.88,1.652,3.18,2.74,1.576,2.584,{5} <0,1,2,3,4,5>



Time taken to build model (full training data) : 0 seconds

=== Model and evaluation on training set ===

Clustered Instances

0      493 ( 50%)
1      315 ( 32%)
2       98 ( 10%)
3       36 (  4%)
4       20 (  2%)
5       18 (  2%)
```

#### SimpleKMeans

Now that I had a number of clusters (6) I was able to use K-means with 6 clusters
to get another clustering possibility for the data. Unfortunately, it looks like it
found an entirely different set of clusters as instead of having two clusters with
80% of the data as in Canopy, it had the data roughly spread out equally among 
the clusters. That is one of the documented flaws with K-means however so I was
not terribly surprised.

```
=== Run information ===

Scheme:       weka.clusterers.SimpleKMeans -init 0 -max-candidates 100 -periodic-pruning 10000 -min-density 2.0 -t1 -1.25 -t2 -1.0 -N 6 -A "weka.core.EuclideanDistance -R first-last" -I 500 -num-slots 1 -S 10
Relation:     clustering-weka.filters.unsupervised.attribute.Remove-R1
Instances:    980
Attributes:   10
              Category 1
              Category 2
              Category 3
              Category 4
              Category 5
              Category 6
              Category 7
              Category 8
              Category 9
              Category 10
Test mode:    evaluate on training data


=== Clustering model (full training set) ===


kMeans
======

Number of iterations: 16
Within cluster sum of squared errors: 121.5907193304435

Initial starting points (random):

Cluster 0: 0.64,1.2,2.27,0.64,1.42,2.83,3.2,2.79,1.47,2.38
Cluster 1: 0.61,1.12,0.22,0.53,0.58,1.2,3.17,2.82,1.63,3.12
Cluster 2: 0.99,2.96,1.71,0.45,1.36,1.96,3.19,2.69,1.38,2.32
Cluster 3: 0.64,1.64,0.34,0.62,0.64,2.22,3.18,3.1,1.98,2.8
Cluster 4: 1.22,1.16,2.18,0.55,1.38,2.52,3.19,2.66,1.92,2.54
Cluster 5: 0.7,2.24,2.32,0.63,0.72,2.12,3.19,2.65,1.28,2.42

Missing values globally replaced with mean/mode

Final cluster centroids:
                           Cluster#
Attribute      Full Data          0          1          2          3          4          5
                 (980.0)    (150.0)    (195.0)     (52.0)    (316.0)    (147.0)    (120.0)
==========================================================================================
Category 1        0.8932     0.8103     0.9355      1.064     0.8253     0.9963     0.9066
Category 2        1.3526     1.3904     1.3247     2.3631     1.2794     1.2659      1.212
Category 3        1.0133     2.3451     0.4184     1.0804     0.4278     1.2563     1.5304
Category 4        0.5325     0.5726     0.3941     1.0483     0.5357     0.5678     0.4322
Category 5        0.9397     1.1241     0.7709     1.1008     0.7693     1.3494     0.8608
Category 6        1.8429     2.1508     1.4438     2.1496     1.6992      2.445     1.6145
Category 7        3.1809     3.1937     3.1709     3.1846     3.1798     3.1829     3.1804
Category 8        2.8351     2.7887     2.8394     2.7417     2.8796     2.8547     2.7851
Category 9        1.5694     1.5767     1.5121     1.4875     1.6912     1.5928     1.3398
Category 10       2.7992     2.4625     3.2537     2.5046     2.7596     2.5786     2.9837




Time taken to build model (full training data) : 0.02 seconds

=== Model and evaluation on training set ===

Clustered Instances

0      150 ( 15%)
1      195 ( 20%)
2       52 (  5%)
3      316 ( 32%)
4      147 ( 15%)
5      120 ( 12%)
```

#### FarthestFirst

The final clustering method I tried was FarthestFirst with 6 canopy clusters 
which found results much closer to that of Canopy than K-means. It found one
super-sized cluster with 65% of the data and two smaller clusters with 18% and
12% of the data and then finally two very small clusters with <5% of the data.

```
=== Run information ===

Scheme:       weka.clusterers.FarthestFirst -N 6 -S 1
Relation:     clustering-weka.filters.unsupervised.attribute.Remove-R1
Instances:    980
Attributes:   10
              Category 1
              Category 2
              Category 3
              Category 4
              Category 5
              Category 6
              Category 7
              Category 8
              Category 9
              Category 10
Test mode:    evaluate on training data


=== Clustering model (full training set) ===


FarthestFirst
==============

Cluster centroids:

Cluster 0
	 1.47 1.04 0.43 0.48 0.74 1.1 3.17 3.01 1.63 3.2
Cluster 1
	 1.95 1.52 1.94 3.44 0.64 2.94 3.2 2.62 1.54 2.46
Cluster 2
	 0.7 1.48 2.43 0.58 1.82 2.38 3.2 3.02 2.72 2.48
Cluster 3
	 0.93 0.64 0.22 0.43 3.26 3.13 3.18 2.8 1.5 2.66
Cluster 4
	 0.7 1.8 3.62 1.37 1.46 1.62 3.19 2.75 1.12 3.42
Cluster 5
	 1.06 3.12 1.58 0.48 0.56 3.34 3.18 2.67 1.76 2.94



Time taken to build model (full training data) : 0.01 seconds

=== Model and evaluation on training set ===

Clustered Instances

0      636 ( 65%)
1        4 (  0%)
2      178 ( 18%)
3       39 (  4%)
4       10 (  1%)
5      113 ( 12%)
```

