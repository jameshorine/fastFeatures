
#' Sample rows and columns of a dataframe
sample_indices <- function(feature_columns, nrows_, column_proportion, record_proportion) {

        random_columns <- sample(x = feature_columns,
                                size = round(x = column_proportion*length(feature_columns), digits = 0),
                                replace = FALSE)

        random_rows   <- sample(x = 1:nrows_,
                                size = round(x = nrows_*record_proportion,digits = 0),
                                replace = TRUE)

    return(list(random_rows=random_rows, random_columns=random_columns))
}