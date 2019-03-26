.data.table.aware = TRUE

#'L1 Lasso Selection From Dense Predictor Space.
#'
#' @param df \code{data.table}-type data matrix
#' @param target_column Character string identifying the target column
#' @param feature_columns Character vector identifying the feature columns to investigate
#' @param column_proportion Numeric on the interval (0,1), this is the percentage of columns randomly sampeled
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
#' \item Bunea, Florentina et al. “Penalized least squares regression methods and applications to neuroimaging” NeuroImage vol. 55,4 (2010): 1519-27.
#' \item Abram, Samantha V et al. “Bootstrap Enhanced Penalized Regression for Variable Selection with Neuroimaging Data” Frontiers in neuroscience vol. 10 344. 28 Jul. 2016, doi:10.3389/fnins.2016.00344
#' \item Santosa, Fadil; Symes, William W. (1986). "Linear inversion of band-limited reflection seismograms". SIAM Journal on Scientific and Statistical Computing. SIAM. 7 (4): 1307–1330. doi:10.1137/0907087
#' \item Tibshirani, Robert (1996). "Regression Shrinkage and Selection via the lasso". Journal of the Royal Statistical Society. Series B (methodological). Wiley. 58 (1): 267–88. JSTOR 2346178
#' \item Jerome Friedman, Trevor Hastie, Robert Tibshirani (2010). Regularization Paths for Generalized Linear Models via Coordinate Descent. Journal of Statistical Software, 33(1), 1-22. URL http://www.jstatsoft.org/v33/i01/.
#' \item Knockoff Filtering as presented in Data Science and Predictive Analytics (UMich HS650). http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/17_RegularizedLinModel_KnockoffFilter.html#10_knockoff_filtering
#' }
#'
#' @details \code{lassoSelector} is a parallelized Bootstrap LASSO built on the \code{glmnet} package from Hastie et. al. The underlying glmnet framework does not appear to be compatiable with \code{data.table}, as such, \code{data.table}-
#'
#' @export

lassoSelector <- function(df, target_column, feature_columns, column_proportion, n_iterations, l1_lambda, glmnet_family){

  num_cores <- parallel::detectCores()

  set.seed(seed = 1234, kind = "Mersenne-Twister")

  temp_results <- pbmcapply::pbmclapply(X = 1:n_iterations,
                                        FUN = function(X){
                                          random_columns <- sample(x = feature_variables,
                                                                   size = round(x = column_proportion*length(feature_variables),
                                                                                digits = 0),
                                                                   replace = FALSE)

                                          temp_mdl <- glmnet::glmnet(x = data.matrix(df[,random_columns, with = F]),
                                                                     y = data.matrix(df[,target_variable, with = F]),
                                                                     family = glmnet_family,
                                                                     alpha = 1, lambda = l1_lambda,
                                                                     intercept = FALSE)

                                          return(data.table::data.table(as.data.frame(as.matrix(coef(temp_mdl))), keep.rownames = TRUE))
                                        },
                                        mc.cores = num_cores
  )

  res <- data.table:::merge.data.table(x = data.table::rbindlist(temp_results)[, list(count = .N), by = rn],
                                       y = data.table::rbindlist(temp_results)[s0 > 0, list(countInc = .N), by = rn],
                                       by = "rn")[ , list("Variable" = rn, "Conditional Variable Inclusion Probability" = countInc / count)]

  return(res)
}

