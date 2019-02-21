context("test-all_samples")

suppressPackageStartupMessages(library(dplyr))

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


test_that("Total number of files are intact", {
  d <- all_samples() %>%
    group_by(file) %>%
    summarize(total_lines = n())

  expect_equal(nrow(d), 6)
  expect_equal(ncol(d), 2)

})
