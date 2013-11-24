---
title: Introduction to Biclustering
description: An introduction to biclustering technique
author: rejuvyesh
status: in progress
lastmodified: 24 November, 2013
belief: likely
tags: biclustering, matlab, mtba, machine learning

---

This is the first post in _hopefully_ a series of posts on biclustering algorithms. The posts would also serve as an example for usage of [MTBA](http://iitk.ac.in/iil/mtba/), the matlab toolbox I have implemented.

Biclustering, as the word itself suggests, is somehow related to clustering. So understanding biclustering requires us to first see what's clustering.

# Clustering

Clustering is one of the most fundamental techniques in _unsupervised learning_. The main idea is fairly ^[May be even deceptively] simple: organize objects into groups such that the members are similar in some way. The definition of **similarity** here, gives rise to a wide variety of problems and their solutions via various algorithms.

For a more detailed overview of clustering, see surveys by Jain et.al.[^jain1][^jain2] or Berkhin [^berkhin].

[^jain]: Jain, A. K., Murty, M. N., & Flynn, P. J.(1999). [Data clustering: a review](http://www.cs.rutgers.edu/~mlittman/courses/lightai03/jain99data.pdf). ACM computing surveys (CSUR), 31(3), 264-323.
[^jain2]: Jain, A. K.(2010). [Data clustering: 50 years beyond K-means](http://biometrics.cse.msu.edu/Presentations/FuLectureDec5.pdf). Pattern Recognition Letters, 31(8), 651-666.
[^berkhin]: Berkhin, P. (2006). [A survey of clustering data mining techniques](http://www-static.cc.gatech.edu/fac/Charles.Isbell/classes/reading/papers/berkhin02survey.pdf). In Grouping multidimensional data (pp. 25-71). Springer Berlin Heidelberg.
