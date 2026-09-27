#### Preamble ####
# Purpose: Cleans the Toronto Beaches Water Quality data for analysis.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed
# - 02-download_data.R must have been run
# Make sure you are in the `STA2453-assignment-1` rproj


#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/toronto_beaches_water_quality.csv")

cleaned_data <-
  raw_data |>
  select(-X_id, -geometry) |>
  mutate(
    collectionDate = as.Date(collectionDate)
  )

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
