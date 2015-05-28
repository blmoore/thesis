\chapter{Introduction}

\section{Abstract}\\
Recent advances in chromosome conformational capture technology have permitted genome-wide assessment of
higher-order chromatin structure in a variety of cell types. This
structural information in conjunction with data produced by the ENCODE
consortium offers an unprecedented opportunity to quantitatively
investigate the relationship between locus level chromatin features
(such as DNA methylation, histone modification and transcription
factor binding) and higher-order chromatin organisation. \\

Hi-C genome-wide pairwise interactions can be reduced to an
eigenvector summary metric that captures the arrangement of the genome
into nuclear ‘compartments’ that have been shown to represent two
distinct fractions of chromatin: gene dense, transcriptionally active
regions and relatively gene poor, inactive regions. However the
relationships between such higher-order phenomena and locus level
features remain controversial and have not been quantitatively
studied. Similarly, the extent to which such datasets intersect, and
how they relate to one another across cell types, is poorly
understood. \\

We have built genome-wide, quantitative models describing higher-order
chromatin structure based on the underlying constellations of locus
level features, such as the levels of histone modifications and
DNA-binding proteins. In three very different cell types, Random
Forest based regression models achieved high predictive accuracy even
when regularised to as few as 6 predictive features (e.g. r =
0.86). Two histone marks, H3K79me2 and H3K4me2, were consistently
identified as important predictors of compartment identity across all
3 cell-types, suggesting a heightened significance for these specific
modifications with regard to higher-order chromatin structure. However
the models otherwise proved to be surprisingly cell type specific,
with largely inconsistent influential variables, and notably reduced
predictive power when a model for a particular cell type was applied
to other cell types. \\

This statistically rigorous modelling approach offers new insights
into the contribution of locus level features to nuclear organisation
in diverse cell types, and produces testable hypotheses that may
enable a greater understanding of higher-order chromatin structure. In
addition, the overall modelling accuracy on regions totalling more
than 1.3 GB of the human genome implies the presence of general rules and
mechanisms for higher-order chromatin assembly.

\chapter*{Glossary}
\addcontentsline{toc}{chapter}{Glossary}
\vspace{-24pt}
\begin{itemize}
\item[An {\bf eigenvector},] as used in this work, is a lower-dimensional
  summary of Hi-C interaction matrices that captures the broad open
  and closed chromatin states along a chromosome. Formally, an eigenvector is any non-zero vector $\vec{x}$ that satisfies
  $\mathbf{A}\vec{x} = \lambda \vec{x}$ for a given square matrix
  $\mathbf{A}$ and corresponding eigenvalue $\lambda$. In principal
  components analysis, the first principal component eigenvector
  represents the axis upon which the original data can be projected
  while retaining maximal variance.
\item[The {\bf glasso}] (or Graphical LASSO, least
  absolute shrinkage and selection operator) builds a conditional
  dependence graph from a set of related variables. By increasing
  the tuning parameter, a greater number of variables will be
  filtered as conditionally independent from the other remaining variables.
 % applies the LASSO
 %  penalty, a restriction on the sum of absolute values, to the inverse
 %  covariance matrix of a set of variables. Increasing this penalty
 %  increases the sparseness of the resulting covariance matrix,
 %  reducing matrix components to $0$ indicating that the row and column
 %  variables are conditionally independent given the remaining non-zero
 %  components.
The glasso is conceptually related to an earlier algorithm\cite{Meinshausen2006} that built a
  graphical model by applying lasso regression to each variable in turn, using
  all others as predictors.
\item[{\bf HMMs}] (hidden Markov models) are models which represent
  non-independent observations according to underlying unobserved
  states. They were used in this work as each 1 Mb region often spans only
  part of a chromosome compartment, meaning adjacent regions are more
  likely to share the same compartment state.
\item[{\bf Random Forest}] is a powerful machine learning method that
  builds a predictive model and is particularly suited to high-dimensional data.
 The Random Forest algorithm grows an
  ensemble of bifurcating decision trees from a bootstrapped sample of
  a training set. Further randomness is introduced by picking a subset
  of available variables at each vertex to test for maximal separation
  of child nodes. The resulting forest can then be used for
  classification, through vote aggregation, or regression, by averaging
  leaf node values across the ensemble.
\item[{\bf Regularisation}] (in the context of machine learning), is the process of
  imposing a penalty on a
  model's complexity. Regularisation was employed to reduce a model
  with many variables to a more understandable and parsimonious model
  with fewer variables.
\end{itemize}


\chapter{Introduction}
The advent of chromosome conformational capture
(3C) based methods has produced a wealth of chromosome topological data
which offer insights into the causal factors and biological
outcomes related to three-dimensional genome structure. Interpretation
of these contact maps, however, remains challenging and requires the
development of
innovative statistical and computational analysis
methods.\cite{Dekker2013, Steffen2012, Hu2013} \\

A high-profile example of computational analyses leading to new
biological insight can be found in Dixon \emph{et al.}\cite{Dixon2012}
wherein the authors characterised ``topological domains'' (also known
as topological associating domains or TADs), a
megabase-scale feature of genome organisation conserved between human
and mice. At lower resolution, Lieberman-Aiden \emph{et
  al.}\cite{Lieberman2011} identified ``A'' and ``B'' nuclear compartments,
made up of regions of between 1 and 5 megabases which showed properties typical
of euchromatin and heterochromatin, respectively. The combination
of these two insights has lead to a model of higher order chromatin
structure whereby groups of TADs assemble into alternating A and B
compartments, reflecting broadly active and inactive chromosomal
regions.\cite{Dekker2013} \\

The link between epigenomic features and local chromatin state has been
analysed computationally in a number of publications, notably in
developing the
Hidden Markov Model-based ChromHMM\cite{Ernst2012} algorithm which predicts states such as active promoters and enhancers, using a
range of histone marks and other underlying features.\cite{Ernst2011} Similarly a Random Forest-based
algorithm was recently developed to predict enhancers from histone
modification data.\cite{Rajagopal2013} At the opposite end of the
spectrum, theoretical mechanistic models of chromatin folding such as the
``strings and binders switch'' model\cite{Barbieri2012} and the ``fractal
globule'' model\cite{Lieberman2011, Mirny2011, Grosberg1988a} have both produced simulated data
that reflects empirical 3C observations and potentially describe the polymer
dynamics of chromatin folding. However few studies have spanned all of
these levels of chromatin structure and nuclear organisation, and it is not yet known how locus-level chromatin features may
be related to higher order genome organisation. \\

The recent comprehensive ChIP-seq datasets
produced by the ENCODE consortium\cite{Dunham2012} combined with Hi-C
genome-wide contact maps in a number of human cell
types\cite{Dixon2012, Lieberman2011, Kalhor2012} present a remarkable
opportunity to investigate the relationships between local
chromatin features and higher order structure. In this work, a
machine-learning approach was employed to model the
compartmental characteristics of large genomic regions based on their
aggregate levels of various histone marks and DNA binding
proteins. Dissection of the resulting models was then used as a
means of gleaning biological insights into the basis of higher order
structure and of highlighting important differences between cell types.
