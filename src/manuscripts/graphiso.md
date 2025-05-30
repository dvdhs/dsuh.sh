---
title: "Number of isomorphism classes in graphs with $n$ vertices"
date: 2023-05-22T15:12:05-05:00
draft: False
---
**This blog post is a re-write up of an interesting problem I encountered during my time taking CMSC 27410 (Honors Combinatorics) at UChicago.**

## The Problem 
Here we note the problem it its entirety. 

> **Problem.** Denote $g_n$ the number of graphs, up to isomorphism, with $n$ vertices. Show that 
> $$\log_2 g_n \sim n^2/2.$$
> as $n\to\infty$.

## Preliminaries
There are a couple premlinary results and notations that we note here that we will be using without proof. They are all very well known results and so this should not be problem. We will be assuming some familiarity with abstract algebra (esp. group theory) and some basic probability. 
- Two graphs $G_1, G_2$ are considered isomorphic if there exists a bijection of vertices $f: V\to V$, such that $$v\sim u \quad \text{implies} \quad f(v) \sim f(u)$$ where $\sim$ denotes that two vertices are neighbors. 
- We denote the symmetric group of order $n$ as $S_n$. We can consider this the group of permutations of $n$ elements. In particular $\sigma\in S_n$ has a obvious action on $x$ via permutation. 
- The *orbit* of an element $x\in X$ are the elements of $X$ which can be reached by $x$ via action from $G$, i.e. $$\{g\cdot x: g\in G\}.$$ 

Finally, we note the following famous lemma.

> **Lemma. (Burnside)**  Suppose $G$ is a finite group acting on $X$. For each $g\in G$, we can denote $\operatorname{fix}_ X(g)$ the set of elements in $X$ that are fixed under the action of $g$ (i.e. $g\cdot x = x$). Then $$\left| X/G\right| = \frac{1}{|G|}\sum_{g\in G}|\operatorname{fix}_X(g)|.$$

It will become evident why this result will be useful later on. 

## Solution
First, we can glean a couple insights. Consider $\mathrm{Graph}(n)$, the set of all graphs with $n$ vertices, i.e. $$\mathrm{Graph}(n)=\{(V,E): |V|=n\}.$$ We first consider the number of graphs that are isomorphic to some graph, say $G\in \mathrm{Graph}(n)$.  If we label all the vertices of $G$ from $1$ through $n$, we can note that any isomorphism of graphs $f$ will simply be a permutation of the labels of vertices of $G$ by definition (recall that a permutation can be considered a bijection from a finite set to itself). Thus we know that the number of isomorphism classes in $\mathrm{Graph}(n)$ is in fact the number of orbits in $\mathrm{Graph}(n)$ under the action of $S_n$, since any two graphs in the same orbit are reachably by a composition of permutations (isomorphisms). 

From here, we can apply Burnside's Lemma to obtain $$g_n = \frac{1}{|S_n|}\sum_{\sigma\in S_n} |\mathrm{fix}_ {\mathrm{Graph}(n)}(\sigma)|. $$ We can observe that $\operatorname{fix}_ {\mathrm{Graph}(n)}(\sigma)$ is the set of graphs $G\in \mathrm{Graph}(n)$ such that  $\sigma\in \operatorname{Aut}(G)$. From here, we can "pull out" the identity permutation $e\in S_n$ from the summation: $$\frac{1}{|S_n|}\sum_{\sigma\in S_n} |\mathrm{fix}_ {\mathrm{Graph} (n)}(\sigma)| = \frac{1}{|S_n|}\left( |\mathrm{fix}_ {\mathrm{Graph(n)}} (e)| + \sum_{\substack{\sigma\in S_n \\ \sigma\neq e}} |\mathrm{fix}_ {\mathrm{Graph}(n)}(\sigma)| \right).$$ Let us try to fill in some concrete values. It is well know that $|S_n|=n!$. Since the identity is always in the automorphism group (trivially), we can note that $$|\mathrm{fix}_ {\mathrm{Graph(n)}} (e)| = |\mathrm{Graph}(n)| = 2^{\binom{n}{2}}.$$

where the last equality (again, well-known) comes from the fact that for any pair of vertices, we have the choice of creating an edge between those vertices or not to create any valid graph. Therefore, we reach $$g_n = \frac{1}{n!}{2^{\binom n2}} + \frac{1}{n!}\sum_{\substack{\sigma\in S_n \\ \sigma\neq e}} |\mathrm{fix}_{\mathrm{Graph}(n)}(\sigma)|. \tag{$\star$}$$ So far the mathematics we had use has been rather routine; but worry not as we have just now reached the crux of this problem. It is to determine the (asymptotic) value of the summation in $(\star)$. 

We can note that in essence, we are finding the average number of non-trivial automorphisms in $\mathrm{Graph}(n)$ as $n\to\infty$.

### Non-Trivial Isomorphisms of $\mathrm{Graph}(n)$
From here, we will roughly sketch the proof as a thourough proof is too complex for a blog post. For specific information, one can check out the original treatment in [[Erdos & Renyi, 1963]](https://link.springer.com/article/10.1007/BF01895716). We can build up the result we want by first considering the following. A *random graph with $n$ vertices* is a graph with $n$ vertices constructed such that each edge between any two vertices has a probability $p$ of forming. For our purposes, we will consider $p=1/2$.  Then we consider the quantity $P(\sigma)$, which is the probability on a random graph that $\sigma\in S_n$ is a automorphism. We first consider a result for $k$-cycles. 

----

> **Lemma 1.** If $\sigma$ is a $k$-cycle, then $$P(\sigma) = 2^{-(n-2)k}.$$

*Proof (sketch)*. Suppose $k=2$. Pick any two vertices $u,v$ of the random graph $G$. Then if $u\sim a$ then it must be that $v\sim a$ in order for $\sigma$ to be an automorphism, where $\sigma$ is the transposition $(uv)$.  There are $2^{k-2}$ possible edge arrangements for $u$ (excluding edges to $v$), so in this case $$P(\sigma) =  2^{k-2}\cdot2^{-k+2}\cdot 2^{-k+2} = 2^{-k+2}.$$ We can repeat this logic for $3$-cycles to get $2^{-2k+4}$, and so on for $k$-cycles. **∎**

---
It is easy to observe that summing over all $P(\sigma)$, the terms accounting for the transpositions dominates as $n\to\infty$. Therefore, we can conclude
---

> **Lemma 2.**  Suppose $G\in \mathrm{Graph}(n)$ has non-trivial automorphisms. Then $$|S_n\cap \mathrm{Aut}(G)| = 1\qquad \text{a.s. as } n\to\infty$$ Namely, the one nontrivial automorphism is a transposition. 

*Proof (sketch).* Since the $P(\sigma)$ terms from the tranpositions dominate, we can conclude from conditional probability and Lemma 1. ∎

Let us denote $h_n = |\mathrm{Graph}(n)|$. From Lemma 2, we know that any graph which does have a nontrivial automorphism, it is almost surely a transposition (for big $n$). So we can count this by the following procedure. First, generate a random graph with $n-1$ vertices. Take some vertex $v$. Then we can create such a graph by adding a new vertex $u$ such that it has the same neighbors as $v$, then choosing to create an edge between $u,v$ or not. Thus asympotically there are $\sim 2n h_{n-1}$ such graphs. Thus in the limit, the density of graphs with non-trivial automorphisms (denoted $d$) is $$d= \lim_{n\to\infty} \frac{2nh_{n-1}}{h_n} = \lim_{n\to\infty} \frac{2n\cdot 2^{\binom{n-1}{2}}}{2^{\binom n 2}} \to 0$$
i.e. for big $n$, any random graph will have only a trivial automorphism group with very high probability. Thus if we pass $(\star)$ through the limit, we can know that $|\mathrm{fix}_{\mathrm{Graph}(n)}| = 0$ with very high probability. Therefore in the limit, we can write $$g_n\sim \frac{1}{n!} 2^{\binom n 2}$$ and we can see that $$\begin{align*}
2^{\binom n 2}/n! = \frac{2^{\frac{n!}{2!(n-2)!}}}{n!} = \frac{2^{\frac{n(n-1)}{2}}}{n!}
\end{align*}$$
Therefore by log rules, $$
\log_2 g_n = \frac{n(n-1)}{2} - \log_2 n!$$
where since $\log_2n!$ grows subquadratically[^1], we can conclude that $$\log_2 g_n \sim n^2/2.$$ as desired. 

[^1]: This is a bit of an handwave but one can observe that $\log n! \sim n\log n - n$ through e.g. [Ramanujuan's estimation](https://en.wikipedia.org/wiki/Stirling%27s_approximation#See_also) or estimation on the derivative of $\log x!$ via the Gamma function. 

## Afterword
The reason I chose this problem was because I thought the intersection of probability and algebra in a combinatorics problem was quite interesting. While any well trained modern combinatorist will easily point out that these subjects have been indispensible tools in the field for a long time, I was personally quite shocked at the mosaic of techniques required here when I first solved this question. Thus I thought it appropriate to give it a rough treatment here.




