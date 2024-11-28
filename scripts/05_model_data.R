#### Preamble ####
# Purpose: Builds the BHM model
# Author: Tanmay Sachin Shinde
# Date: 26 November, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: 
# - analysis_data must be stored in data/analysis_data
# - the 'brms' package must be installed and loaded
# - the 'arrow' package must be installed and loaded

# install.packages("brms")

library(brms)
library(arrow)
library(dplyr)
library(ggplot2)
library(tidyr)

analysis_data <- read_parquet("../data/analysis_data/analysis_data.parquet")

# Using data from Jan 2012 to Dec 2017 for training the model
train_data <- analysis_data %>% filter(time <= 71)

formula <- bf(unitValue_lg ~ 1 + (1 | category) + cpi + purchaseVolume + time)

bhm_model <- brm(
  formula = formula,
  data = train_data,
  family = gaussian(),
  prior = c(
    prior(normal(0, 10), class = "Intercept"),
    prior(normal(0, 10), class = "b"),
    prior(cauchy(0, 5), class = "sd")
  ),
  chains = 4, iter = 6000, cores = 4, warmup = 2000, init = "0",
    control = list(adapt_delta = 0.99, max_treedepth = 15)
)


# Summary of the model
summary(bhm_model)

# Posterior predictive checks
pp_check(bhm_model)

#### Save model ####
saveRDS(
  bhm_model,
  file = "bhm_model.rds"
)

#### Visualize results and Testing ####

future_test_data <- analysis_data %>% filter(time >= 72)

future_predictions <- predict(
  model,
  newdata = future_test_data,
  allow_new_levels = TRUE,  # Allow unseen region/category levels
  summary = TRUE  # Get the mean and confidence intervals
)

future_predictions <- data.frame(future_predictions)

check_data <-  cbind(future_test_data, future_predictions)

categories <- unique(analysis_data$category)

for (cat in categories) {
  check_data_cat <- check_data %>% filter(category == cat)
  
  plot <- ggplot(check_data_cat, aes(x = time)) +
    geom_line(aes(y = unitValue_lg, color = "Actual Value"), linewidth = 1) +
    geom_line(aes(y = Estimate, color = "Predicted Value"), linewidth = 1)
  labs(
    title = "Unit Value Actual vs. Predicted Jan 2018 - Dec 2018",
    x = "Time",
    y = "Value",
    color = "Legend"
  ) +
    scale_color_manual(
      values = c("Actual Unit Value" = "red", "Predicted Unit Value" = "blue")
    ) +
    theme_minimal()
  
  ggsave(filename = paste0("../other/plots/", gsub("[^A-Za-z0-9]", "_", cat), ".png"), plot = plot)
}
