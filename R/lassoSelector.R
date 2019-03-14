#'L1 Lasso Sellection From Dense Predictor Space.
#'
#' @param df \code{data.table}-type data matrix
#' @param target_column Character string identifying the target column
#' @param feature_columns Character vector identifying the feature columns to investigate
#' @param column_proportion Numeric on the interval (0,1), this is the percentage of columns randomly sampeled
#' @param n_iterations The number of bootstrap replications
#' @param l1_lambda The LASSO L1 penalty parameter
#' @param glmnet_family Character string, see glmnet for more information
#'
#' @return data.table object of Conditional Variable Inclusion Probability
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

                                          temp_coefs_table <- data.table::data.table(as.data.frame(as.matrix(coef(temp_mdl))), keep.rownames = TRUE)
                                          return(temp_coefs_table)
                                        },
                                        mc.cores = num_cores
  )

  res <- data.table:::merge.data.table(x = data.table::rbindlist(temp_results)[rn != "(Intercept)"][, list(count = .N), by = rn],
                                       y = data.table::rbindlist(temp_results)[rn != "(Intercept)"][s0 > 0, list(countInc = .N), by = rn],
                                       by = "rn")[ , list("Variable" = rn, "Conditional Variable Inclusion Probability" = countInc / count)]

  return(res)
}

