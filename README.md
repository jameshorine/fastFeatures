
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `fastFeatures`

`fastFeatures` is an `R` package built from the ground up with one goal
in mind: Quickly slice and dice through feature spaces too large to
quickly manually examine so that you can build a predictive model that
is easier to explain to explain to non-technical stakeholders.
`fastFeatures` provides an easy-to-use interface to fast variable
selection methods. The implemented feature selection functions are:

1.  `lassoSelector` is built from the notion of Conditional Variable
    Inclusion Probability as introduced by Bunea et. al \[1\]. Built on
    `glmnet` and can accept any regression of the families:
      - gaussian
      - binomial
      - poisson
      - multinomial
      - cox
      - mgaussian
2.  `rfSelector` is a `ranger`-powered bootstrapped random forest. The
    same methodology applies with the twist that we are only considering
    variables whoes conditional importance contribution is more than
    1/(number of features in bootstrapped model at replication i).

## Installation

You can install the released version of fastFeatures from
[GitHub](https://github.com/) with:

1.  
<!-- end list -->

``` r
install.packages("devtools")
```

2.  
<!-- end list -->

``` r
devtools::install_github("jameshorine/fastFeatures")
```

## Useage

The general recipe for using this package is:

1.  Prepare data appropriately.
2.  Assign your data, target, and feature variables to convenient
    objects
      - data, target, features, are some easy to remember choices
3.  Run your preferred method.
4.  Interpret results.

## Inspiration

The data used to build this package may be found at
<https://www.kaggle.com/c/santander-customer-transaction-prediction/data>.
This is a good first pass data set as there are (just) too many
predictors to reasonably assess manually, and there are enough records
(N ~ 200000) that meaningful computational time will be spent searching
for any true (and unknown to us) signal.

## Refernences

1.  Bunea, Florentina et al. “Penalized least squares regression methods
    and applications to neuroimaging” NeuroImage vol. 55,4 (2010):
    1519-27.
2.  Abram, Samantha V et al. “Bootstrap Enhanced Penalized Regression
    for Variable Selection with Neuroimaging Data” Frontiers in
    neuroscience vol. 10 344. 28 Jul. 2016,
    <doi:10.3389/fnins.2016.00344>
3.  Santosa, Fadil; Symes, William W. (1986). “Linear inversion of
    band-limited reflection seismograms”. SIAM Journal on Scientific and
    Statistical Computing. SIAM. 7 (4): 1307–1330. <doi:10.1137/0907087>
4.  Tibshirani, Robert (1996). “Regression Shrinkage and Selection via
    the lasso”. Journal of the Royal Statistical Society. Series B
    (methodological). Wiley. 58 (1): 267–88. JSTOR 2346178
5.  Jerome Friedman, Trevor Hastie, Robert Tibshirani (2010).
    Regularization Paths for Generalized Linear Models via Coordinate
    Descent. Journal of Statistical Software, 33(1), 1-22. URL
    <http://www.jstatsoft.org/v33/i01/>.
6.  Knockoff Filtering as presented in Data Science and Predictive
    Analytics (UMich HS650).
    <http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.html#10_knockoff_filtering>
