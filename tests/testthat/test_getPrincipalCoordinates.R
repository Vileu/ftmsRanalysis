context("getPrincipalCoordinates function")

test_that("basic tests on getPrincipalCoordinates", {
  data("exampleProcessedPeakData")
  
  peakObj <- edata_transform(exampleProcessedPeakData, "pres")
  res1 <- getPrincipalCoordinates(peakObj)
  
  expect_true(is.numeric(res1))
  expect_equal(dim(res1), c(20, 5))
  expect_true(!is.null(attr(res1, "R^2")))
  expect_true(is.numeric(attr(res1, "R^2")))
  expect_equal(length(attr(res1, "R^2")), 5)
  
  res2 <- getPrincipalCoordinates(peakObj, dist_metric="manhattan")
  
  res3 <- getPrincipalCoordinates(peakObj, n_dims=10)
  expect_equal(dim(res3), c(20, 10))
  
  res4 <- getPrincipalCoordinates(peakObj, dist_metric="jaccard")
  res5 <- getPrincipalCoordinates(exampleProcessedPeakData, dist_metric="jaccard")
  
  expect_identical(res4, res5)

})

test_that("tests that should fail on getPrincipalCoordinates", {
  expect_error(res1 <- getPrincipalCoordinates(peakObj, n_dims=-1))
  expect_error(res2 <- getPrincipalCoordinates(peakObj, n_dims=20))
  expect_error(res2 <- getPrincipalCoordinates(peakObj, dist_metric="not a real metric"))
})
