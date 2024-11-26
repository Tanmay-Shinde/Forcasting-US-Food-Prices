#### Preamble ####
# Purpose: EDA for all outcome and predictor variables
# Author: Tanmay Sachin Shinde
# Date: 25 November, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: Cleaned dataset must be stored in data/analysis_data


library(knitr)
library(ggplot2)
library(dplyr)
library(arrow)

analysis_data <- read_parquet("../data/analysis_data/analysis_data.parquet")



# Summary statistics for outcome variable
summary_stats_outcome <- analysis_data %>%
  summarise(
    mean = mean(unitValue_lg, na.rm = TRUE),
    median = median(unitValue_lg, na.rm = TRUE),
    sd = sd(unitValue_lg, na.rm = TRUE),
    min = min(unitValue_lg, na.rm = TRUE),
    max = max(unitValue_lg, na.rm = TRUE)
  )

kable(summary_stats_outcome)


# Histogram for unitValue_lg

ggplot(analysis_data, aes(x = unitValue_lg)) +
  geom_histogram(bins = 30, fill = "blue", alpha = 0.7, color = "black") +
  labs(title = "Distribution of Log Unit Value", x = "Log Unit Value", y = "Frequency") +
  theme_minimal()

filtered_data <- analysis_data %>%
  filter(grepl("Census Region", region, ignore.case = TRUE))

# Boxplot of unitValue_lg by region
ggplot(filtered_data, aes(x = region, y = unitValue_lg)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  labs(title = "Log Unit Value by Region", x = "Region", y = "Log Unit Value") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

transformed_data <- analysis_data %>% 
  mutate(time = time/12 + 2012) %>%
  group_by(time) %>%
  summarise(mean_unitValue_lg = mean(unitValue_lg, na.rm = TRUE))

ggplot(transformed_data, aes(x = time, y = mean_unitValue_lg)) +
  geom_line(color = "blue", size = 0.9) +
  labs(title = "Trend Over Time: Log-Transformed Unit Value of Food Prices",
       x = "Time (in Years)",
       y = "Log Unit Value") +
  theme_minimal()


# Summary statistics for cpi
summary_stats_outcome <- analysis_data %>%
  summarise(
    mean = mean(cpi, na.rm = TRUE),
    median = median(cpi, na.rm = TRUE),
    sd = sd(cpi, na.rm = TRUE),
    min = min(cpi, na.rm = TRUE),
    max = max(cpi, na.rm = TRUE)
  )

kable(summary_stats_outcome)


# Histogram for cpi values
ggplot(analysis_data, aes(x = cpi)) +
  geom_histogram(bins = 100, fill = "blue", alpha = 0.7, color = "black") +
  labs(title = "Distribution of CPI", x = "CPI", y = "Frequency") +
  theme_minimal()

filtered_data <- analysis_data %>%
  filter(grepl("Census Region", region, ignore.case = TRUE))

# Boxplot of unitValue_lg by region
ggplot(filtered_data, aes(x = region, y = cpi)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  labs(title = "Consumer Price Index (CPI) by Region", x = "Region", y = "CPI") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

transformed_data <- analysis_data %>% 
  mutate(time = time/12 + 2012) %>%
  group_by(time) %>%
  summarise(mean_cpi = mean(cpi, na.rm = TRUE))

ggplot(transformed_data, aes(x = time, y = mean_cpi)) +
  geom_line(color = "blue", size = 0.9) +
  labs(title = "Trend Over Time: Consumer Price index",
       x = "Time (in Years)",
       y = "CPI") +
  theme_minimal()

# Summary statistics for purchase volume variable
summary_stats_outcome <- analysis_data %>%
  summarise(
    mean = mean(purchaseVolume, na.rm = TRUE),
    median = median(purchaseVolume, na.rm = TRUE),
    sd = sd(purchaseVolume, na.rm = TRUE),
    min = min(purchaseVolume, na.rm = TRUE),
    max = max(purchaseVolume, na.rm = TRUE)
  )

kable(summary_stats_outcome)

filtered_data <- analysis_data %>%
  filter(grepl("Census Region", region, ignore.case = TRUE))

# Boxplot of unitValue_lg by region
ggplot(filtered_data, aes(x = region, y = purchaseVolume)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  labs(title = "Purchase Volume by Region", x = "Region", y = "purchaseVolume") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

transformed_data <- analysis_data %>% 
  mutate(time = time/12 + 2012) %>%
  group_by(time) %>%
  summarise(mean_pvol = mean(purchaseVolume, na.rm = TRUE))

ggplot(transformed_data, aes(x = time, y = mean_pvol)) +
  geom_line(color = "blue", size = 0.9) +
  labs(title = "Trend Over Time: Purchase Volume",
       x = "Time (in Years)",
       y = "Purchase Volume") +
  theme_minimal()

# Histogram for purchase volume values

ggplot(analysis_data, aes(x = purchaseVolume)) +
  geom_histogram(bins = 100, fill = "blue", alpha = 0.7, color = "black") +
  labs(title = "Distribution of Purchase Volume", x = "Standardized Purchase Volumes", y = "Frequency") +
  theme_minimal()


