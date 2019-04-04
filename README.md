
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `fastFeatures`

`fastFeatures` is an `R` package built from the ground up with one goal
in mind: Quickly slice and dice through feature spaces too large to
(quickly) manually examine so that you may (and shall) build a
predictive model that is easy to explain and share. `fastFeatures`
provides an easy-to-use interface to fast variable selection methods.
The implemented feature selection functions are:

1.  `cVIP` is built from the notion of (Conditional) Variable Inclusion
    Probability as introduced by Bunea et. al \[1\]. Built on `glmnet`
    and can accept any regression of the families:
      - `gaussian`
      - `binomial`
      - `poisson`
      - `multinomial`
      - `cox`
      - `mgaussian`
2.  `rf_cVIP` (should be) a `ranger`-powered bootstrapped random forest.
    The same methodology applies with a twist that I have not yet
    figured out.

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

## TODO:

1.  finish `rf_cVIP`
2.  test against more large data sets of type
      - N-large, p-large
      - p\>\>N
      - N-large, p-highly correlated
3.  write vignette
4.  unit test (grumble, made last for a reason)

## Refernences

1.  Bach,Francis. (2008) “Bolasso: model consistent Lasso estimation
    through the bootstrap”. URL <https://arxiv.org/abs/0804.1302>
2.  Bunea, Florentina et al. “Penalized least squares regression methods
    and applications to neuroimaging” NeuroImage vol. 55,4 (2010):
    1519-27.
3.  Abram, Samantha V et al. “Bootstrap Enhanced Penalized Regression
    for Variable Selection with Neuroimaging Data” Frontiers in
    neuroscience vol. 10 344. 28 Jul. 2016,
    <doi:10.3389/fnins.2016.00344>
4.  Santosa, Fadil; Symes, William W. (1986). “Linear inversion of
    band-limited reflection seismograms”. SIAM Journal on Scientific and
    Statistical Computing. SIAM. 7 (4): 1307–1330. <doi:10.1137/0907087>
5.  Tibshirani, Robert (1996). “Regression Shrinkage and Selection via
    the lasso”. Journal of the Royal Statistical Society. Series B
    (methodological). Wiley. 58 (1): 267–88. JSTOR 2346178
6.  Jerome Friedman, Trevor Hastie, Robert Tibshirani (2010).
    Regularization Paths for Generalized Linear Models via Coordinate
    Descent. Journal of Statistical Software, 33(1), 1-22. URL
    <http://www.jstatsoft.org/v33/i01/>.
7.  Knockoff Filtering as presented in Data Science and Predictive
    Analytics (UMich HS650).
    <http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.html#10_knockoff_filtering>
8.  Knockoff Filtering and Bootstrapped LASSO as presented in UMich H650
    Notes.
    <http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter>.
