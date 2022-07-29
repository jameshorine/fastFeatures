## code to prepare `DATASET` dataset goes here

create_test_data <- function(seed=1234) {
    set.seed(seed)

    x1 <- rnorm(100, 10, 2)
    x2 <- rnorm(100, 0, 1)
    irrelavant_feature <- rnorm(100)
    y <- 1 + 10*x1 + x2
    test_data <- data.frame(
        y = y,
        x1 = x1,
        x2 = x2,
        x3 = irrelavant_feature
    )
    set.seed(NULL)
    return(test_data)
}

test_data_1 <- create_test_data(1234)
usethis::use_data(test_data_1, overwrite = TRUE, internal=TRUE)