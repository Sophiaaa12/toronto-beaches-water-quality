#### Preamble ####
# Purpose: Explores the cleaned Toronto Beaches Water Quality data.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed
# - 03-clean_data.R must have been run


#### Workspace setup ####
library(tidyverse)


#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Explore data ####
glimpse(analysis_data)

range(analysis_data$collectionDate)

analysis_data |>
  count(beachName, sort = TRUE)

summary(analysis_data$eColi)

analysis_data |>
  summarise(
    missing_eColi = sum(is.na(eColi)),
    percent_missing = mean(is.na(eColi)) * 100
  )