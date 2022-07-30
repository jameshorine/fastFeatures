test_that("sample indices works", {
  
  results <- sample_indices(
    feature_columns=c(1,2,3,4),
    nrows_ = 10,
    column_proportion = 0.75,
    record_proportion = 0.5
  )

  expect_type(results, "list")
  expect_length(results, 2)

})

test_that("sample matrix works", {

  x <- rep(rnorm(100), 4)
  dim(x) <- c(100, 4)

  samp <- sample_matrix(as.data.table(x), 1, c(2,3,4), 0.66, 1)
  
  expect_length(samp, 2)
  expect_named(samp, c("x", "y"))
  expect_equal(dim(samp$x), c(100,2))
  expect_equal(dim(samp$y), c(100,1))


})