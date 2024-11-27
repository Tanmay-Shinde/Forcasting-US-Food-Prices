#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset.
# Author: Tanmay Sachin Shinde
# Date: 26 November 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The 'testthat' package must be installed and loaded
# - The arrow package must be installed and loaded
# - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(arrow)

analysis_data <- read_parquet("../data/analysis_data/analysis_data.parquet")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 94855 rows - more categories and regions than simulated dataset
if (nrow(analysis_data) == 94855) {
  message("Test Passed: The dataset has 94855 rows.")
} else {
  stop("Test Failed: The dataset does not have 94855 rows.")
}

# Check if the dataset has 7 columns
if (ncol(analysis_data) == 7) {
  message("Test Passed: The dataset has 7 columns.")
} else {
  stop("Test Failed: The dataset does not have 7 columns.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# # Check if there are no empty strings in region and category
# if (all(analysis_data$region != "" & analysis_data$category)) {
#   message("Test Passed: There are no empty strings in 'region' and 'category'.")
# } else {
#   stop("Test Failed: There are empty strings in one or more columns.")
# }


# Check whether Region, Category are as expected
# test_that("region and category contain expected values only", {
#   expected_regions <- c("Northeast", "Midwest", "South", "West")
#   expected_categories <- c("Grains", "Fruits", "Vegetables", "Dairy", "Meats", "Salads", "Other Foods")
# 
#   expect_true(all(analysis_data$region %in% expected_regions))
#   expect_true(all(analysis_data$category %in% expected_categories))
# })

# Check if time is a continuous variable 0 <= time <= 83
test_that("time is within the range 0-83", {
  expect_true(all(analysis_data$time >= 0 & analysis_data$time <= 83))
  expect_true(all(is.numeric(analysis_data$time)))
})

# Check if cpi values are numeric
test_that("cpi is numeric", {
  expect_true(all(is.numeric(analysis_data$cpi)))
})

# Check if all purchase volume values are numeric
test_that("purchase volume are numeric", {
  expect_true(all(is.numeric(analysis_data$purchaseVolume)))
})

# Check if unit values are numeric 
test_that("unit value is numeric", {
  expect_true(all(is.numeric(analysis_data$unitValue_lg)))
})