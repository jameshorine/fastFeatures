test_that("main function works", {

  test_data <- as.data.table(fastFeatures:::test_data_1)
  set.seed(1234)
  results <- fastFeatures::cVIP(
    df = test_data,
    target_column = "y",
    feature_columns = c("x1", "x2", "x3"),
    column_proportion=0.75,
    record_proportion=0.99,
    n_iterations=10,
    l1_lambda=3,
    glmnet_family="gaussian"
  )
  expect_equal(results$"Conditional Variable Inclusion Probability"[2], 1)
  expect_equal(results$"Conditional Variable Inclusion Probability"[3], 0.4, tolerance=0.0001)
  expect_equal(results$"Conditional Variable Inclusion Probability"[4], 0.285714, tolerance=0.0001)
  expect_s3_class(results, "data.frame")

  set.seed(NULL)

})


test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
