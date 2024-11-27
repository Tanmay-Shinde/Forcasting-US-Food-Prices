#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset.
# Author: Tanmay Sachin Shinde
# Date: 26 November 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - The 'testthat' package must be installed and loaded
# - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("../data/simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 2352 rows
if (nrow(simulated_data) == 2352) {
  message("Test Passed: The dataset has 2352 rows.")
} else {
  stop("Test Failed: The dataset does not have 2352 rows.")
}

# Check if the dataset has 6 columns
if (ncol(simulated_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# # Check if there are no empty strings in region and category
# if (all(simulated_data$region != "" & simulated_data$category)) {
#   message("Test Passed: There are no empty strings in 'region' and 'category'.")
# } else {
#   stop("Test Failed: There are empty strings in one or more columns.")
# }

# Check whether Region, Category are as expected
test_that("region and category contain expected values only", {
  expected_regions <- c("Northeast", "Midwest", "South", "West")
  expected_categories <- c("Grains", "Fruits", "Vegetables", "Dairy", "Meats", "Salads", "Other Foods")
  
  expect_true(all(simulated_data$region %in% expected_regions))
  expect_true(all(simulated_data$category %in% expected_categories))
})

# Check if time is a continuous variable 0 <= time <= 83
test_that("time is within the range 0-83", {
  expect_true(all(simulated_data$time >= 0 & simulated_data$time <= 83))
  expect_true(all(is.numeric(simulated_data$time)))
})

# Check if cpi values are in a reasonable range and is a numeric value
test_that("cpi is within the range -2 to 2", {
  expect_true(all(simulated_data$cpi >= -2 & simulated_data$cpi <= 2))
  expect_true(all(is.numeric(simulated_data$cpi)))
})

# Check if all purchase volume values are positive
test_that("purchase volume is always positive", {
  expect_true(all(simulated_data$purchase_volume > 0))
  expect_true(all(is.numeric(simulated_data$purchase_volume)))
})

# Check if unit values are in a reasonable range and is a numeric value
test_that("cpi is within the range -2 to 2", {
  expect_true(all(simulated_data$log_unit_value >= -2 & simulated_data$log_unit_value <= 2))
  expect_true(all(is.numeric(simulated_data$log_unit_value)))
})