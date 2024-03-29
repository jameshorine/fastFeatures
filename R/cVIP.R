.data.table.aware = TRUE

#'L1 Lasso Selection From Dense Predictor Space.
#'
#' @param df \code{data.table}-type data matrix
#' @param target_column Character string identifying the target column
#' @param feature_columns Character vector identifying the feature columns to investigate
#' @param column_proportion Numeric on the interval (0,1), this is the percentage of columns randomly sampeled without replacement.
#' @param record_proportion Numeric on the interval (0,1], default is 1. This is the percentage of records to random select for boot strap sampling, with replacement.
#' @param n_iterations The number of bootstrap replications
#' @param l1_lambda The LASSO L1 penalty parameter
#' @param glmnet_family Character string, see glmnet for more information
#'
#' @author James Patrick Horine
#'
#' @return \code{data.table}-type object of the (Conditional) Variable Inclusion Probability
#'
#' @references
#' \itemize{
#' \item Bach,Francis. (2008) "Bolasso: model consistent Lasso estimation through the bootstrap". URL https://arxiv.org/abs/0804.1302
#' \item Bunea, Florentina et al. “Penalized least squares regression methods and applications to neuroimaging” NeuroImage vol. 55,4 (2010): 1519-27.
#' \item Abram, Samantha V et al. “Bootstrap Enhanced Penalized Regression for Variable Selection with Neuroimaging Data” Frontiers in neuroscience vol. 10 344. 28 Jul. 2016, doi:10.3389/fnins.2016.00344
#' \item Santosa, Fadil; Symes, William W. (1986). "Linear inversion of band-limited reflection seismograms". SIAM Journal on Scientific and Statistical Computing. SIAM. 7 (4): 1307–1330. doi:10.1137/0907087
#' \item Tibshirani, Robert (1996). "Regression Shrinkage and Selection via the lasso". Journal of the Royal Statistical Society. Series B (methodological). Wiley. 58 (1): 267–88. JSTOR 2346178
#' \item Jerome Friedman, Trevor Hastie, Robert Tibshirani (2010). Regularization Paths for Generalized Linear Models via Coordinate Descent. Journal of Statistical Software, 33(1), 1-22. URL http://www.jstatsoft.org/v33/i01/.
#' \item Knockoff Filtering as presented in Data Science and Predictive Analytics (UMich HS650). http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.html#10_knockoff_filtering
#' \item Knockoff Filtering and Bootstrapped LASSO as presented in UMich H650 Notes. http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.R
#' \item Dinov, ID. (2018) Data Science and Predictive Analytics: Biomedical and Health Applications using R, Springer (ISBN 978-3-319-72346-4)
#' }
#'
#' @details \code{cVIP} is a parallelized Bootstrap LASSO built on the \code{glmnet} package from Hastie et. al. The underlying glmnet framework does not appear to be compatiable with \code{data.table}, as such, \code{data.table}-type inputs will be down-cast to \code{base::data.matrix}-types when needed.
#'
#' @export

cVIP <- function(df, target_column, feature_columns, column_proportion, record_proportion = 0.05, n_iterations, l1_lambda, glmnet_family){

  validate_user_input(df, target_column ,feature_columns)

  num_cores <- parallel::detectCores()

  temp_results <- lapply(X = 1:n_iterations,
                                        FUN = function(X){

                                          samp_mtrx <- sample_matrix(df, target_column, feature_columns, column_proportion, record_proportion)
                                          temp_mdl <- glmnet::glmnet(x = samp_mtrx$x,
                                                                     y = samp_mtrx$y,
                                                                     family = glmnet_family,
                                                                     alpha = 1, lambda = l1_lambda,
                                                                     intercept = FALSE)

                                          return(coef(temp_mdl))
                                        }
  )

  res <- compute_results(temp_results)
  return(res)
}
