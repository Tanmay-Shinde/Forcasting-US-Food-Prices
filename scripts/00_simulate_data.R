#### Preamble ####
# Purpose: Simulates a dataset of the food prices for different regions, time periods, and product category
# Author: Tanmay Sachin Shinde
# Date: 26 November 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: The `tidyverse` and `arrow` packages must be installed


#### Workspace setup ####
library(tidyverse)
library(arrow)
set.seed(304)

analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

cat <- unique(analysis_data$category)

#### Simulate data ####
# Region
regions <- c("Northeast", "Midwest", "South", "West")

# Category
categories <- c("Grains", "Fruits", "Vegetables", "Dairy", "Meats", "Salads", "Other Foods")

# Time - there can be a total of 28 region, category combinations. Thus for each month,
# we need to record 28 values. We need to do this for 84 months (Jan 2012 to Dec 2018)
time <- rep(0:83, times = 28)

# Normalized CPI values - expected to follow a normal distribution
cpi <- rnorm(2352, mean = 0, sd = 0.4)

# Purchase Volume - expected to be more concentrated around lower values - follows a exponentional distribution
pvol <- rexp(2352, rate = 1.5)

# Log unit Value - to represent the percentage change in price which should be concentrated around 0
# ranging between -1 to 1, thus following a normal distribution
lg_unit_val <- rnorm(2352, mean = 0, sd = 0.5)

region_category <- expand.grid(regions = regions, categories = categories)

# Repeat region-category combinations for 84 months
region_category <- region_category[rep(1:nrow(region_category), each = 84), ]

# Combine all data into a single dataframe
simulated_data <- data.frame(
  time = time,
  region = region_category$regions,
  category = region_category$categories,
  cpi = cpi,
  purchase_volume = pvol,
  log_unit_value = lg_unit_val
)

#### Save data ####
write_csv(simulated_data, "data/simulated_data/simulated_data.csv")
