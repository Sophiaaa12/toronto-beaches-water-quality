#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned Toronto beach
  # water quality dataset.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` and `testthat` packages must be installed
# - 03-clean_data.R must have been run
# Make sure you are in the `STA2453-assignment-1` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 102,534 rows
test_that("dataset has 102,534 rows", {
  expect_equal(nrow(analysis_data), 102534)
})

# Test that the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(analysis_data), 5)
})

# Test that 'beachName' is character type
test_that("'beachName' is character", {
  expect_type(analysis_data$beachName, "character")
})

# Test that 'siteName' is character type
test_that("'siteName' is character", {
  expect_type(analysis_data$siteName, "character")
})

# Test that 'collectionDate' is Date type
test_that("'collectionDate' is Date", {
  expect_s3_class(analysis_data$collectionDate, "Date")
})

# Test that beach IDs are positive
test_that("'beachId' contains positive values", {
  expect_true(all(analysis_data$beachId > 0))
})

# Test that non-missing E. coli values are positive
test_that("non-missing 'eColi' values are positive", {
  expect_true(all(analysis_data$eColi[!is.na(analysis_data$eColi)] > 0))
})

# Test that there are no missing beach names or site names
test_that("no missing beach or site names", {
  expect_true(
    all(!is.na(analysis_data$beachName)) &
      all(!is.na(analysis_data$siteName))
  )
})

# Test that there are no empty beach names or site names
test_that("no empty beach or site names", {
  expect_false(
    any(analysis_data$beachName == "" |
          analysis_data$siteName == "")
  )
})

# Test that the dataset contains at least two beaches
test_that("dataset contains at least two beaches", {
  expect_true(n_distinct(analysis_data$beachName) >= 2)
})