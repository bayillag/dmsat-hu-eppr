
#!/usr/bin/env Rscript
# Download training datasets

library(utils)

download_datasets <- function() {
  # Clinical trials data
  download.file(
    url = "https://raw.githubusercontent.com/example/dmsat-data/main/clinical_trials.csv",
    destfile = "1_TRAINING/Day2-Statistical_Analysis/datasets/clinical_trials.csv"
  )
  
  # Pandemic indicators
  download.file(
    url = "https://raw.githubusercontent.com/example/dmsat-data/main/pandemic_indicators.xlsx",
    destfile = "1_TRAINING/Day2-Statistical_Analysis/datasets/pandemic_indicators.xlsx"
  )
  
  # Messy data exercise
  download.file(
    url = "https://raw.githubusercontent.com/example/dmsat-data/main/messy_data.csv",
    destfile = "1_TRAINING/Day1-Data_Management/Exercises/messy_data.csv"
  )
}

download_datasets()
message("Datasets downloaded successfully!")