---
title: Introduction to Biclustering
description: An introduction to biclustering technique
author: rejuvyesh
status: finished
lastmodified: 30 November, 2013
belief: likely
math: true
tags: biclustering, matlab, mtba, machine learning
---

This is the first post in _hopefully_ a series of posts on biclustering algorithms. The posts would also serve as an example for usage of [MTBA](http://iitk.ac.in/iil/mtba/), the matlab toolbox I have contributed to.

Biclustering, as the word itself suggests, is somehow related to clustering. So understanding biclustering requires us to first see what's clustering.

# Clustering

Clustering is one of the most fundamental techniques in _unsupervised learning_. The main idea is fairly ^[May be even deceptively] simple: organize objects into groups such that the members are similar in some way. The definition of **similarity** here, gives rise to a wide variety of problems and their solutions via various algorithms.

What's common in these clustering algorithms is that we have a dataset, usually represented as an $n \times m$ matrix, where $n$ is the number of samples and $m$ are the features for these samples. A typical clustering algorithm will either cluster these samples according to some measure along one of these features or cluster the features together according to some measure along the samples. 

![Scatter plot of Clusters  [(Source)](http://home.deib.polimi.it/matteucc/Clustering/tutorial_html/)](/images/clustering.png)


For a more detailed overview of clustering, see surveys by Jain et.al.[^jain1][^jain2] or Berkhin [^berkhin].

# Biclustering

Now that we have some idea what clustering is, we can talk about biclustering. Let's see how a heatmap of a matrix looks like:

![Heatmap of a matrix](/images/matrix_heatmap.png )

And how we can rearrange this matrix to make the partitions obvious:

![Heatmap of rearranged matrix](/images/rearrange_heatmap.png )

This leads us to the definition of biclustering:

> Biclustering, co-clustering, or two-mode clustering is a data mining technique which allows simultaneous clustering of the rows and columns of a matrix.
> -- [Wiki-sama](https://en.wikipedia.org/wiki/Biclustering)

Clustering both rows and columns together, could appear a little unintuitive but its very useful. Maybe an example would help.

## Example

Let's say you are organizing a food party. Different people would have different tastes: some might want Italian, others might like Chinese and so on. You want people with similar cravings for food to stay together for more discussions and the like. You also want food that are more similar like may be vegetarian or non-vegetarian to be served together. 

So you decide to send out a survey to each guest asking if they like a particular food item or not. From their responses you create a $50 \times 20$ binary matrix $\mathbf{A}$, where $\mathbf{A}_{ij} = 1$ if the guest $i$ likes the food-item $j$. Plotting its heatmap using MTBA:

```matlab
>> heatmap(A)
```
![Heatmap of Matrix](/images/party_heatmap.png )

Here the rows are the guests and columns are the food-items with pink color corresponding to $1$ and yellow to $0$.

But the problem is that you only 3 rooms booked and want to distribute people and food evenly so that they do not crowd a single room. Also you want enough food in each room. Here you find that biclustering can be very useful. For example if you bicluster this data using Spectral co-clustering in MTBA as:

```matlab
>> biclust(A, 'bsgp', 'n', 3, 'display', 1) % We want 3 biclusters
```
![Heatmap of biclustered Matrix](/images/party_cluster_heatmap.png ) 

After biclustering, the rows and columns of the matrix have been reordered to show the assignment of food to rooms and rooms to guests. Although not everyone may enjoy the food, this solution does ensure that a majority does.

# Conclusion

So here we are. Hopefully the contrived example helped you both understand and visualize the process. Also it's important that you realize that any data that can be represented in the form of matrix, is amenable to biclustering. Although it's very popular in the domain of gene expression data analysis especially those from microarray experiments, it's also been applied to document texts as well as many other problems. There are number of proposed bicluster structures and algorithms. If you are interested in a more detailed review see the surveys [^madeira][^tanay][^busygin].

[^jain1]: Jain, A. K., Murty, M. N., & Flynn, P. J.(1999). [Data clustering: a review](http://www.cs.rutgers.edu/~mlittman/courses/lightai03/jain99data.pdf). ACM computing surveys (CSUR), 31(3), 264-323.
[^jain2]: Jain, A. K.(2010). [Data clustering: 50 years beyond K-means](http://web.archive.org/web/20130401102038/http://biometrics.cse.msu.edu/Presentations/FuLectureDec5.pdf). Pattern Recognition Letters, 31(8), 651-666.
[^berkhin]: Berkhin, P. (2006). [A survey of clustering data mining techniques](http://www-static.cc.gatech.edu/fac/Charles.Isbell/classes/reading/papers/berkhin02survey.pdf). In Grouping multidimensional data (pp. 25-71). Springer Berlin Heidelberg.

[^madeira]: Madeira, S. C., & Oliveira, A. L.(2004). [Biclustering algorithms for biological data analysis: a survey](http://www.bioinf.uni-freiburg.de/Lehre/Courses/2011_SS/MLForLifeScience/PDF/IEEE_Transactions_on_computational_Biology_and_Bioinformatics_2004_Madeira.pdf). Computational Biology and Bioinformatics, IEEE/ACM Transactions on, 1(1), 24-45.
[^tanay]: Tanay, A., Sharan, R., & Shamir, R. (2005). [Biclustering algorithms: A survey](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.118.8302&rep=rep1&type=pdf). Handbook of computational molecular biology, 9, 26-1
[^busygin]: Busygin, S., Prokopyev, O., & Pardalos, P. M.(2008). [Biclustering in data mining](http://www.sciencedirect.com/science/article/pii/S0305054807000159). Computers & Operations Research, 35(9), 2964-2987.
