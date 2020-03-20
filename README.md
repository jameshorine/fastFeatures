
<!-- README.md is generated from README.Rmd. Please edit that file -->
Background: `fastFeatures`
==========================

`fastFeatures` is an `R` package built from the ground up with one goal in mind: High-speed variable selection in typical statistical/data science settings so that you may (and shall) build a predictive model that is easy to explain and share.

Namely, we are focusing on problem of the type:

1.  Large N
2.  Large P
3.  ||P|| ∼ ||N||
4.  ||P|| &gt;&gt; ||N||

where

-   N = number of records in the usual sense
-   P = the dimensionality of the predictor space

`fastFeatures` provides an easy-to-use interface to fast variable selection methods. The implemented feature selection functions are:

1.  `cVIP` is built from the notion of (Conditional) Variable Inclusion Probability as introduced by Bunea et. al \[1\]. Built on `glmnet` and can accept any regression of the families:
    -   `gaussian`
    -   `binomial`
    -   `poisson`
    -   `multinomial`
    -   `cox`
    -   `mgaussian`
2.  \[TODO\] `rf_cVIP` (should be) a `ranger`-powered bootstrapped random forest. The same methodology applies with a twist that I have not yet figured out.

Installation
============

You can install the released version of fastFeatures from [GitHub](https://github.com/) with:

devtools:

``` r
install.packages("devtools")
```

UPDATE: It turns out I was wrong about installation via devtools, and there appears to be a bit of a community kerfuffle between Hadley and the folks at `devtools`...per <https://community.rstudio.com/t/vignettes-suddenly-stopped-installing/18391>, try installing as:

``` r
devtools::install_github("jameshorine/fastFeatures", 
                         build_vignettes = TRUE,
                         build_opts = c("--no-resave-data", "--no-manual"),
                         force = T)
```

Note: you will need to install `knitr`, `kableExtra` so that R may build the markdown vignette.

Vignette
========

You may access the package Vignette via

``` r
browseVignettes(package = "fastFeatures")
```

Useage
======

#### General Recipe

The general recipe for using this package is:

1.  Prepare data appropriately.
2.  Assign your data, target, and feature variables to convenient objects
    -   data, target, features, are some easy to remember choices
3.  Run your preferred method.
4.  Interpret results.

#### Function Call

Below is an outline of how to call `cVIP`. The inputs: - `gaussian` - `train` - `target_variable` - `feature_variables` - `n_iterations` - `l1_lambda` - `glmnet_family`

are required user-defined inputs.

The `record_proportion` parameter has a default value fo 5%. This was chosen intentionally because the author (James) desires speed for this application. If you (the user) desire to sample more of the records simply increase the value.

``` r
fastFeatures::cVIP(df = train,
                   target_column = target_variable,
                   feature_columns = feature_variables,
                   column_proportion = 0.25,
                   record_proportion = 0.05,
                   n_iterations = 1000,
                   l1_lambda = 0.0099,
                   glmnet_family = "binomial")
```

Notes
=====

1.  This is not built for the windows platform. I am making use of `pbmcapply::pbmclapply()` because speed is as important as user feedback; It is simply nice to see progress indicators for a long calculation.

2.  The "mixing" properties of this algorithm have not been explored at this time. Users should use their judgement in parameter settings. If you have many predictors, you may not adequately explore the (conditional) Variable Inclusion Probability distribution.

3.  Contrary to \[1\], \[2\] (below), `l1_lambda` is NOT optimized at every iteration of the algorithm.

TODO:
=====

1.  implement random forest equivalent: `rf_cVIP`
2.  port to python per discussion with Zach Miller
3.  implement "heat map" of variable inclusion as a function of *λ*
4.  test against more large data sets of type
    -   N-large, p-large
    -   p&gt;&gt;N
    -   N-large, p-highly correlated
5.  write vignette - DONE
6.  add vignette content to repo readme.
7.  unit test (grumble, made last for a reason)

Feedback
========

Please direct any feedback to the issues section!

Refernences
===========

1.  Bach,Francis. (2008) "Bolasso: model consistent Lasso estimation through the bootstrap". URL <https://arxiv.org/abs/0804.1302>
2.  Bunea, Florentina et al. “Penalized least squares regression methods and applications to neuroimaging” NeuroImage vol. 55,4 (2010): 1519-27.
3.  Abram, Samantha V et al. “Bootstrap Enhanced Penalized Regression for Variable Selection with Neuroimaging Data” Frontiers in neuroscience vol. 10 344. 28 Jul. 2016, <doi:10.3389/fnins.2016.00344>
4.  Santosa, Fadil; Symes, William W. (1986). "Linear inversion of band-limited reflection seismograms". SIAM Journal on Scientific and Statistical Computing. SIAM. 7 (4): 1307–1330. <doi:10.1137/0907087>
5.  Tibshirani, Robert (1996). "Regression Shrinkage and Selection via the lasso". Journal of the Royal Statistical Society. Series B (methodological). Wiley. 58 (1): 267–88. JSTOR 2346178
6.  Jerome Friedman, Trevor Hastie, Robert Tibshirani (2010). Regularization Paths for Generalized Linear Models via Coordinate Descent. Journal of Statistical Software, 33(1), 1-22. URL <http://www.jstatsoft.org/v33/i01/>.
7.  Knockoff Filtering as presented in Data Science and Predictive Analytics (UMich HS650). <http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.html#10_knockoff_filtering>
8.  Knockoff Filtering and Bootstrapped LASSO as presented in UMich H650 Notes. <http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.R>
9.  Dinov, ID. (2018) Data Science and Predictive Analytics: Biomedical and Health Applications using R, Springer (ISBN 978-3-319-72346-4)
