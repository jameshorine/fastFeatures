## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(fastFeatures)
library(ggplot2)

## -----------------------------------------------------------------------------
data("kaggleSample")

#random seed)
set.seed(4321)

#grab a subset of data
train_idx <- sample(1:dim(kaggleSample)[1], size = round(x = 0.75 *dim(kaggleSample)[1], digits = 0), replace = F)
train <- kaggleSample[train_idx,]

## -----------------------------------------------------------------------------
dim(train)
table(train$target)
object.size(train)

## -----------------------------------------------------------------------------
#id columns ----
record_identifier <- "ID_code"

#target ----
target_variable <- "target"

#optional columns to exclude ---- 
opt_cols_exclude <- NULL

#features ----
feature_variables <- names(train)[!names(train)%in% c(target_variable, 
                                                      record_identifier, 
                                                      opt_cols_exclude)
                                  ]


## -----------------------------------------------------------------------------

results <- fastFeatures::cVIP(df = train,
                                    target_column = target_variable,
                                    feature_columns = feature_variables,
                                    column_proportion = 0.25,
                                    record_proportion = 0.25,
                                    n_iterations = 10,
                                    l1_lambda = 0.0099,
                                   glmnet_family = "binomial")


## ----fig.align='center', fig.width=7, fig.height=4, message=FALSE-------------
ggplot(results, aes(x=`Conditional Variable Inclusion Probability`)) + 
 geom_histogram(aes(y=..density..), colour="black", fill="white", binwidth=0.02)+
 geom_density(alpha=.2, fill="#FF6666") + xlab("Conditional Variable Inclusion Probability")

## -----------------------------------------------------------------------------
thresh <- 0.5
included_vars_index <- ifelse(results[["Conditional Variable Inclusion Probability"]] > thresh, T, F)

print(sum(included_vars_index) / length(feature_variables))

