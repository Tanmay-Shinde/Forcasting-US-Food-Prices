#### Preamble ####
# Purpose: Cleans the raw data obtained from the USDA Economic Research Service
# Author: Tanmay Shinde
# Date: 22 November, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A

#### Workspace setup ####
# install.packages("readxl")
library(readxl)

#### Clean data ####
data <- read_excel('../data/raw_data/FMAP.xlsx', sheet = 2)

