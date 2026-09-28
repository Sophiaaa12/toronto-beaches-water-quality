#### Preamble ####
# Purpose: Simulates a dataset of Toronto beach water quality observations.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `toronto-beaches-water-quality` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# Beach names
beaches <- c(
  "Cherry Beach",
  "Marie Curtis Park East Beach",
  "Sunnyside Beach",
  "Woodbine Beach"
)

# Site names
sites <- c(
  "1W",
  "2W",
  "3W"
)

analysis_data <- tibble(
  beachId = sample(1:4, size = 100, replace = TRUE),
  beachName = sample(beaches, size = 100, replace = TRUE),
  siteName = sample(sites, size = 100, replace = TRUE),
  collectionDate = sample(
    seq(as.Date("2026-06-01"), as.Date("2026-09-07"), by = "day"),
    size = 100,
    replace = TRUE
  ),
  eColi = sample(1:200, size = 100, replace = TRUE)
)



#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")
