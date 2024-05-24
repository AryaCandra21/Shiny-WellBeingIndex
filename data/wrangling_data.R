library(tidyverse)
data <- readxl::read_excel("data_wellbeing.xlsx") 
data %>%
  pivot_longer(
    `IW equal domain_2010`:`IW equal indikator_2021`,
    names_to = "name",
    values_to = "value") %>%
  separate(
    col = "name",
    sep = "_",
    into = c("indikator",
             "tahun")) %>%
  writexl::write_xlsx("data_tidy_well_being.xlsx")
