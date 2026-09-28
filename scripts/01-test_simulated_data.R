#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Toronto beach
  # water quality dataset.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `toronto-beaches-water-quality` rproj


#### Workspace setup ####
library(tidyverse)

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 100 rows
if (nrow(analysis_data) == 100) {
  message("Test Passed: The dataset has 100 rows.")
} else {
  stop("Test Failed: The dataset does not have 100 rows.")
}

# Check if the dataset has 5 columns
if (ncol(analysis_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if the 'beachName' column contains only valid beach names
valid_beaches <- c(
  "Cherry Beach",
  "Marie Curtis Park East Beach",
  "Sunnyside Beach",
  "Woodbine Beach"
)

if (all(analysis_data$beachName %in% valid_beaches)) {
  message("Test Passed: The 'beachName' column contains only valid beach names.")
} else {
  stop("Test Failed: The 'beachName' column contains invalid beach names.")
}

# Check if the 'siteName' column contains only valid site names
valid_sites <- c("1W", "2W", "3W")

if (all(analysis_data$siteName %in% valid_sites)) {
  message("Test Passed: The 'siteName' column contains only valid site names.")
} else {
  stop("Test Failed: The 'siteName' column contains invalid site names.")
}

# Check if the E. coli values are within the simulated range
if (all(analysis_data$eColi >= 1 & analysis_data$eColi <= 200)) {
  message("Test Passed: All E. coli values are within the expected range.")
} else {
  stop("Test Failed: Some E. coli values are outside the expected range.")
}

# Check if collection dates are within the simulated period
if (all(
  analysis_data$collectionDate >= as.Date("2026-06-01") &
  analysis_data$collectionDate <= as.Date("2026-09-07")
)) {
  message("Test Passed: All collection dates are within the expected period.")
} else {
  stop("Test Failed: Some collection dates are outside the expected period.")
}


# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}


# Check if there are no empty strings in character columns
if (all(analysis_data$beachName != "" & analysis_data$siteName != "")) {
  message("Test Passed: There are no empty strings in character columns.")
} else {
  stop("Test Failed: There are empty strings in one or more character columns.")
}


# Check if there are at least two beaches
if (n_distinct(analysis_data$beachName) >= 2) {
  message("Test Passed: The dataset contains at least two beaches.")
} else {
  stop("Test Failed: The dataset contains less than two beaches.")
}