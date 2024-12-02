# Forecasting U.S. Food Prices

## Overview

This paper focuses on building an accurate and reliable model to explore the temporal dynamics of food-at-home prices in the United States at a national level. By incorporating key economic factors such as purchase volume, food categories, and the Consumer Price Index (CPI), our Bayesian Hierarchical Model (BHM) achieves high predictive accuracy (RMSE = 0.058) and effectively forecasts price trends. The study captures category-specific effects and temporal trends, leveraging historical data to predict future price trajectories. Our model will provide policymakers, businesses, and researchers with a robust predictive framework to anticipate market dynamics, mitigate risks, and make data-driven decisions that enhance economic resilience and consumer well-being.

## File Structure

The repo is structured as follows:

-   `data` contains all data (simulation, raw, analysis) relevant to the research.
-   `model` contains the fitted model.
-   `other` contains relevant literature, details about LLM chat interactions, sketches, and plots documenting the predictions of the model.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, and clean data as well as building the model.

## Statement on LLM Usage

Aspects of the code were developed with the assistance of ChatGPT. The **simulation** and **analysis tests** as well as parts of the **data modeling** were generated using these chatbots, and the complete chat history is available in `other/llm_usage/usage.txt`.

## Replication

To replicate the analysis and run the code in this repository, you'll need to install several R packages. You can install them directly from CRAN using the following commands in your R console:

```R
install.packages(c("tidyverse", "rstanarm", "readxl", "dplyr", "tidyr", "lubridate", "arrow", "testthat", "brms", "modelsummary"))
```
