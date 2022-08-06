
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


sample_matrix <- function(df, target_column, feature_columns, column_proportion, record_proportion) {

    sample_idx <- sample_indices(
        feature_columns=feature_columns,
        nrows_=dim(df)[1],
        record_proportion=record_proportion,
        column_proportion=column_proportion
    )

    output <- list(
        x=data.matrix(df[sample_idx$random_rows, sample_idx$random_columns, with=FALSE]),
        y=data.matrix(df[sample_idx$random_rows, target_column, with=FALSE])
    )
    return(output)
}


compute_results <- function(results) {
    results <- do.call(rbind, results)
    results[,1] <- ifelse(results[,1] > 0, 1, 0)
    results <- aggregate(results[,1], by=list(rownames(results)), FUN=mean)
    colnames(results) <- c("Variable", "Conditional Variable Inclusion Probability")
    return(results)
}