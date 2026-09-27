#### Preamble ####
# Purpose: Downloads and saves Toronto Beaches Water Quality data from
# Open Data Toronto.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `opendatatoronto` and `tidyverse` packages must be installed
# Make sure you are in the STA2453-assignment-1` rproj

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# [...ADD CODE HERE TO DOWNLOAD...]
resources <- list_package_resources(
  "https://open.toronto.ca/dataset/toronto-beaches-water-quality/"
)
the_raw_data <- get_resource(resources$id[8])


#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "data/01-raw_data/toronto_beaches_water_quality.csv")

         
