---
title: Understanding Theory of Mutation and Fitness
description: Derivation of an equation Mackay's Information Theoretic framework for understanding sexual reproduction
author: rejuvyesh
status: in progress
lastmodified: 05 January, 2015
belief: certain
math: true
tags: information theory, biology, math
---

I have been reading David Mackay's ITILA book[^itila] on and off again for a few months. The book is a combination of information theory and machine learning, with interesting tid-bits about biology (and other stuff) and is immensely readable. I had skipped a few chapters to read a tantalizingly titled chapter, "_Why have Sex? Information Acquisition and Evolution_".

## Problem

As per [Mackay's assumptions](http://www.inference.phy.cam.ac.uk/mackay/itprnn/ps/265.280.pdf), we define genome size as $G$ bits, with genome of each individual represented by a vector $\mathbf{x}$. Each bit represents two fitness states: good ($x_g=1$) and bad ($x_g=0$). The fitness $F(\mathbf{x})$ of an individual is represented by (Eq. 19.1):
$$ F(\mathbf{x}) = \sum_{g=1}^{G} x_g $$

We define normalized fitness, $f(\mathbf{x}) \equiv F(\mathbf{x})/G$.

Mackay in his simple model of **variation by mutation** assumes that the individual bit $x_g$ are independent of each other and their probability of flipping is taken to be a constant $m$.

In Eq 19.3, Mackay states that working in terms of excess normalized fitness $\delta{f} \equiv f - 1/2$, with the assumption that the mutation rate $m$ is small, the probability distribution of the excess normalized fitness of a child will have mean as:
$$ \overline{\delta{f}}_{child} = (1-2m) \delta{f} $$
and variance as:
$$ \sigma^2 = \frac{m(1-m)}{G} \approx \frac{m}{G} $$

This was the place where I was flummoxed. I am not a biology student, so I wasn't sure how one can arrive to these equation. So while looking for a solution I found [these lecture notes](http://www.nyu.edu/pages/projects/fitch/courses/evolution/html/genetic_drift.html) on genetic drift. The hint was in the [exercises at the end](http://www.nyu.edu/pages/projects/fitch/courses/evolution/html/genetic_drift.html#Exercises).

## Solution

Let rate of forward mutation from $x_{g} = 1$ (good) to $x_{g} = 0$ (bad) = $u$.

Similarly, let rate of backward mutation from $x_{g} = 0$ (bad) to $x_{g} = 1$ (good) = $v$.

At generation $t$, let frequency of good genes be $f_t$.

Frequency of $x_{good}$ in next generation,
$$ f_{t+1} = f_t (1-u) + (1-f_t) v $$

At equilibrium, $f_{t+1} = f_{t}$.

Therefore, equilibrium value of fitness, $\hat{f} = \frac{v}{u+v}$.

Change over a single generation,
$$ \Delta{f} = f_{t+1} - f_t = -(u+v)f_t + v $$

In terms of equilibrium value $\hat{f}$,
$$ \Delta{f} = -(u+v)(f_t -\hat{f}) $$

Adding and subtracting $\hat{f}$ in the LHS of above equation,
$$ f_{t+1} - \hat{f} = f_t - \hat{f} - (u+v)(f_t - \hat{f}) = (1 - u - v)(f_t -\hat{f}) $$

According to the book's assumption, we have on average, $u = v = m$. Therefore,
$$ \hat{f} = \frac{1}{2} $$
$$ f_{t+1} - \frac{1}{2} = (1 - 2m)(f_t - \frac{1}{2}) $$
$$ \delta{f_{t+1}} = (1-2m) \delta{f_t} $$

Now that we have the mean, how do we derive the variance? I'll give a hint. Assume the distribution to be [Binomial](https://en.wikipedia.org/wiki/Binomial_distribution) with probability $p=m$.

Hopefully this is helpful. Let me know if I am mistaken somewhere!

[^itila]: MacKay, David JC. Information theory, inference, and learning algorithms. Vol. 7. Cambridge: Cambridge university press, 2003. [[book](http://www.inference.phy.cam.ac.uk/mackay/itila/book.html)]








