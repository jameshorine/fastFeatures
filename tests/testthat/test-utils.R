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
