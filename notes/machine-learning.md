---
title: Machine Learning
description: [Machine Learning] Notes on introductory machine learning
author: rejuvyesh
math: true
---

# Where and Why?

I mean really? Do you live under a rock?

# Classes of approach

## Supervised

- Given $(x_1, y_1) ... (x_n, y_n)$ where $x_i$ is the data point, $y_i$ is the class/value, choose a function $f(x) = y$.
- No correct function usually.
- **Classification**: $y_i \in \{\text{finite set}\}$. We _separate_ the classes.
- **Regression**: $y_i \in \mathbb{R} or \mathbb{R}^{d}$. We _model_ the data points.

## Unsupervised

- Given $(x^1, ... x^n)$ where $x^i \in \mathbb{R}^k$, find patterns in data.
- **Clustering**
- **Density Estimation**
- **Dimensionality Reduction**

## Semi-supervised

- Given $(x_1, y_1), ..., (x_k, y_k), x_{k+1}, ..., x_{n}$. We predict labels $y_{k+1}, ... y_n$.

## Active Learning

- Ask for information when not sure.

## Decision Theory

- Measure performance. ($\frac{\# wrong}{N}$)
- Game theory: loss matrix

## Reinforcement Learning

- rewards/losses.
- actions, states.
- Maximise lifetime reward.

## Discriminative

- Given $(x^1, y^1), ..., (x^n, y^n)$. We find $p(y|x)$.

## Generative

- Given $(x^1, y^1), ..., (x^n, y^n)$. We find $p(x,y) = f(x|y) p(y) = p(y|x) f(x)$
- More powerful generally (more information).
- Difficult to estimate due to high variances. More data required and may have worse performance.

## [Example] k-Nearest Neighbor (kNN)

- Given $D = \{(x_1, y_1), ..., (x_n, y_n)\}$ where $x_i \in \mathbb{R}^d, y_i \in \{0,1\}$.
- Distance metric $d(x_i, x_j)$
    - Could be simply Euclidean
    $$d(x_i, x_j) = \|x_i - x_j\|^2 = \sum_{k=1}^d (x_{ik} - x_{jk})^2$$
- We take nearest $k$ points and take the **majority vote**.
- Theoretical guarantees as $n \rightarrow \infty$
- **Probabilistic Interpretation**:
    - Fix $k$. Random variable $Y \tilde p$ where
    $$p(y) = fraction of points x_i in N_k(x), s.t. y_i = y$$
    which in conditional form is often written as $p(y|x,D)$. Not technically a conditional probability.
    - Predict $\hat{y} = \arg\,\max_y p(y|x,D)$ ← Discriminative model
- How to choose $k$?
    - Cross Validation.
    - Bias variance tradeoff.
