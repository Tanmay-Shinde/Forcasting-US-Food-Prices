#### Preamble ####
# Purpose: Cleans the raw data obtained from the USDA Economic Research Service
# Author: Tanmay Shinde
# Date: 22 November, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A

#### Workspace setup ####
# install.packages("readxl")
# install.packages("arrow")
library(readxl)
library(dplyr)
library(tidyr)
library(lubridate)
library(arrow)

#### Clean data ####
fmap_data <- read_excel('../data/raw_data/FMAP.xlsx', sheet = 2)

fmap_data$time <- paste(fmap_data$Year, sprintf("%02d", fmap_data$Month), sep = "-")

# Selecting only the relevant variables
analysis_data <- fmap_data %>%
  select(region = Metroregion_name,
         category = EFPG_name,
         time,
         cpi = Price_index_GEKS,
         purchaseVolume = Purchase_grams_wtd,
         unitValue = Unit_value_mean_wtd)

# Handling missing/null values
analysis_data <- analysis_data %>%
  filter(!is.na(unitValue) & !is.na(cpi) & !is.na(purchaseVolume) & !is.na(region) & !is.na(category))

# applying log transformation to the response variable
analysis_data <- analysis_data %>%
  mutate(unitValue_lg = log(unitValue))

# Convert time so that it is a continuous variable
analysis_data <- analysis_data %>%
  mutate(time = time_length(interval(ymd("2012-01-01"), ymd(paste0(time, "-01"))), "months"))


# factorizing categorical variables to numerical values
analysis_data <- analysis_data %>%
  mutate(region = factor(region),
         category = factor(category))

# # removing outliers to ensure consistency in measurements
# remove_outliers <- function(x) {
#   Q1 <- quantile(x, 0.25)
#   Q3 <- quantile(x, 0.75)
#   IQR <- Q3 - Q1
#   x[x >= (Q1 - 1.5 * IQR) & x <= (Q3 + 1.5 * IQR)]
# }
# 
# analysis_data <- analysis_data %>%
#   filter(purchaseVolume %in% remove_outliers(purchaseVolume),
#          unitValue_lg %in% remove_outliers(unitValue_lg))

# normalizing the predictor variables for improving accuracy of Bayesian model
normalize <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}

analysis_data <- analysis_data %>%
  mutate(cpi = normalize(cpi),
         purchaseVolume = normalize(purchaseVolume))

# save as parquet file
write_parquet(analysis_data, "../data/analysis_data/analysis_data.parquet")
