\chapter{Methods}

# Input data

## Hi-C data

Raw Hi-C reads were downloaded from three published datasets through
GEO\citep{Barrett2013} or the SRA\citep{Leinonen2011a} with identifiers: GSE35156 (H1 hESC), GSE18199 (K562) and SRX030113 (GM12878). These paired reads were
mapped independently to theand mapped to the genome (hg19/GRCh37). Mapping was performed using the `hiclib` software package\citep{Imakaev2012} and `bowtie2`\citep{Langmead2012} with the `--very-sensitive` flag. Mapped reads were then binned into contact maps and iteratively corrected\citep{Imakaev2012}. The `hiclib` software was also used for eigenvector expansion of each intrachromosomal contact map, performed independently on each chromosome arm.

## Locus-level features

Genome-wide ChIP-seq datasets for: 22 DNA binding proteins and 10
histone marks were made available by the ENCODE consortium\citep{Dunham2012, Boyle2014} along with
DNase I hypersensitivity and H2A.z occupancy, for each of the Tier 1
ENCODE cell lines used in this work: H1 hESC, K562 and GM12878. These
data were pre-processed using MACSv2\citep{Zhang2008} to produce fold-change
relative to input chromatin. GC content was also calculated and used in
the featureset.

# Modelling

## Random Forest {#sec:rf}

Random Forest regression\citep{Breiman2001a} was used as implemented in the R
package `randomForest`.\citep{Liaw2002} Parameters of
$mtry = \frac{n}{3} = 12$ and $ntrees =
200$ were assumed as they approximate the defaults and are known to be
largely insensitive.\citep{Hastie2001}

Variable importance within Random Forest regression models was measured
using mean decrease in accuracy in the out-of-bag (OOB) sample. This
represents the average difference (over the forest) between the accuracy
of a tree with permuted and unpermuted versions of a given variable, in
units of mean squared error (MSE).\citep{Cutler2007}

## Model performance

The effectiveness of the modelling approach was measured by four
different metrics. Prediction accuracy was assessed by the Pearson
correlation coefficient between the predicted and observed eigenvectors
(determined by 10-fold cross-validation), and the root mean-squared
error (RMSE) of the same data. Classification error, when predictions
where thresholded into $A \geq 0; B < 0$, was also calculated using
accuracy (% correct classifications or True Positives) and area under
the receiver operating characteristic (AUROC) curve.
Together these give a comprehensive overview of the model performance,
both in terms of regression accuracy of the continuous eigenvector, and
in how that same model could be used to label discrete chromatin
compartments.

For cross-application of cell type specific models, a single Random
Forest regression model was learned from all 1 Mb bins for a given cell
type. This was then used to predict all bins from each of the other two
cell types.

# Variable regions

## Stratification by variability

Median absolute deviation (MAD) was chosen as a robust measure of the
variability in a given 1 Mb block between the three primary cell types
used in this work: H1, K562 and GM12878. Blocks were ranked by this
measure and split into thirds that represented “low” variability (the
third of blocks with the lowest MAD), “mid” and “high” variability. Each
subgroup was then independently modelled using the previously-described
Random Forest approach.

“Flipped” regions are those whose compartment state
differs in one cell type relative to the other two. For example, if a 1
Mb bin was classified as “open” in H1 hESC and ``closed'' in both K562
and GM12878, this is said to be a “flipped” compartment (to open).

## Enhancer enrichment

Enhancer annotations were collected from the ChromHMM / SegWay combined
annotations in each cell type.\citep{Hoffman2013} Enhancers were considered
“shared” if there was an overlapping enhancer annotation in either of
the two other cell types, and labelled as “tissue-specific” otherwise.

# Boundaries

## TADs

TAD boundaries were called using the software provided in \citet{Dixon2012} using their recommended parameters. For the generation
of boundary profiles, the same parameters were used: input features were
averaged into 40 kb bins spanning $\pm500$ kb from the boundary centre.

## Compartments {#sec:compartments}

Compartment boundaries were called by first training a two-state hidden
Markov model (HMM) on the compartment eigenvector and then using the
Viterbi algorithm to predict the most likely state sequence that
produced the observed values. The point at which transitions occurred
between states was taken as a boundary which was then extended $\pm 1.5$
Mb to give a 3 Mb window in which a boundary was though to occur.

To test for the enrichment or depletion of a chromatin feature over a given boundary, a two tailed Mann-Whitney test was used to compare the boundary bin with the ten outermost bins of the window (5 from either side). The significance level at ￼$\alpha = 0.01$ was then Bonferonni-adjusted for multiple testing correction, and results with _p_-values exceeding this threshold were deemed significantly enriched or depleted at a given boundary.

# Giemsa band comparison

Cytogenic band data and Giemsa stain results were downloaded from the
UCSC genome browser (table `cytoBandIdeo`). The
genomic co-ordinates are an approximation of cytogenic band data
inferred from a large number of FISH experiments.\citep{Furey2003}

To compare G-band boundaries with our compartment data, we allowed for a
$\pm 500$ kb inaccuracy in G-band boundary. For each G-band boundary,
the minimum absolute distance to any compartment or TAD boundary was
calculated for each cell type. To generate a null model, \ldots
