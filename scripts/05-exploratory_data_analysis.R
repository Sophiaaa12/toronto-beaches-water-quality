#### Preamble ####
# Purpose: Explores the cleaned Toronto Beaches Water Quality data.
# Author: Siyi Zhu
# Date: 26 September 2026
# Contact: siyi.zhu@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed
# - 03-clean_data.R must have been run
# Make sure you are in the `STA2453-assignment-1` rproj


#### Workspace setup ####
library(tidyverse)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Explore data ####
# Check the structure of the dataset
glimpse(analysis_data)

# Check the collection period
range(analysis_data$collectionDate)

# Check the beaches in the dataset
analysis_data |>
  count(beachName, sort = TRUE)

# Summary of E. coli measurements
summary(analysis_data$eColi)

# Check missing E. coli measurements
analysis_data |>
  summarise(
    missing_eColi = sum(is.na(eColi)),
    percent_missing = mean(is.na(eColi)) * 100
  )


#### E. coli by beach ####
# Compare E. coli measurements across beaches
beach_summary <-
  analysis_data |>
  group_by(beachName) |>
  summarise(
    observations = n(),
    mean_eColi = mean(eColi, na.rm = TRUE),
    median_eColi = median(eColi, na.rm = TRUE),
    max_eColi = max(eColi, na.rm = TRUE)
  ) |>
  arrange(desc(median_eColi))

beach_summary


#### E. coli over time ####
# Add year for exploring changes over time
yearly_data <-
  analysis_data |>
  mutate(year = lubridate::year(collectionDate)) |>
  group_by(year) |>
  summarise(
    observations = n(),
    mean_eColi = mean(eColi, na.rm = TRUE),
    median_eColi = median(eColi, na.rm = TRUE)
  )

yearly_data


#### Visualize the data ####
# Overall distributions
analysis_data |>
  filter(
    !is.na(eColi),
    eColi <= 10000
  ) |>
  ggplot(aes(x = eColi)) +
  geom_histogram(
    bins = 50
  ) +
  scale_x_log10() +
  labs(
    x = "E. coli measurement (log scale)",
    y = "Number of observations"
  ) +
  theme_minimal()

# Median E. coli levels vary across beaches
beach_summary |>
  ggplot(aes(
    x = reorder(beachName, median_eColi),
    y = median_eColi
  )) +
  geom_col() +
  coord_flip() +
  labs(
    x = "Beach",
    y = "Median E. coli (per 100 mL)",
    title = "Median E. coli levels vary across Toronto beaches"
  ) +
  theme_minimal()

# E. coli measurements by sites
analysis_data |>
  filter(
    beachName == "Sunnyside Beach",
    !is.na(eColi)
  ) |>
  ggplot(
    aes(
      x = siteName,
      y = eColi
    )
  ) +
  geom_jitter(
    width = 0.2,
    alpha = 0.12,
    size = 0.7
  ) +
  scale_y_log10() +
  labs(
    x = "Sampling site",
    y = "E. coli measurement (log scale)"
  ) +
  theme_minimal()

# E. coli measurements over time
# By year
yearly_data |>
  ggplot(aes(x = year, y = median_eColi)) +
  geom_line() +
  geom_point() +
  labs(
    x = "Year",
    y = "Median E. coli (per 100 mL)",
    title = "Median E. coli levels by year"
  ) +
  theme_minimal()

# Date within swimming season
analysis_data |>
  filter(!is.na(eColi)) |>
  mutate(
    day_of_year = lubridate::yday(collectionDate)
  ) |>
  ggplot(
    aes(
      x = day_of_year,
      y = eColi
    )
  ) +
  geom_point(
    alpha = 0.08,
    size = 0.5
  ) +
  scale_y_log10() +
  facet_wrap(~ beachName, ncol = 2) +
  scale_x_continuous(
    breaks = c(152, 182, 213, 244),
    labels = c("Jun", "Jul", "Aug", "Sep")
  ) +
  labs(
    x = "Date within swimming season",
    y = "E. coli measurement (log scale)"
  ) +
  theme_minimal()

# By month
beach_month_data <-
  analysis_data |>
  filter(!is.na(eColi)) |>
  mutate(month = lubridate::month(collectionDate, label = TRUE)) |>
  group_by(beachName, month) |>
  summarise(
    median_eColi = median(eColi),
    .groups = "drop"
  )

beach_month_data |>
  ggplot(aes(
    x = month,
    y = median_eColi,
    group = beachName
  )) +
  geom_line() +
  geom_point() +
  facet_wrap(~ beachName) +
  labs(
    x = "Month",
    y = "Median E. coli (per 100 mL)",
    title = "Seasonal E. coli patterns across Toronto beaches"
  ) +
  theme_minimal()

analysis_data |>
  filter(
    !is.na(eColi),
    beachName %in% c(
      "Sunnyside Beach",
      "Marie Curtis Park East Beach"
    )
  ) |>
  mutate(
    month = lubridate::month(
      collectionDate,
      label = TRUE,
      abbr = TRUE
    )
  ) |>
  ggplot(
    aes(
      x = month,
      y = eColi
    )
  ) +
  geom_jitter(
    width = 0.25,
    alpha = 0.12,
    size = 0.7
  ) +
  scale_y_log10() +
  facet_wrap(~ beachName) +
  labs(
    x = "Month",
    y = "E. coli measurement (log scale)"
  ) +
  theme_minimal()

