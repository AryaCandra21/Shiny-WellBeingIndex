library(bs4Dash)
library(plotly)
library(readxl)
library(tidyverse)
library(DT)
library(sf)
library(markdown)
library(ggspatial)

# read data
source("data/read_data.R")

# ui
source("ui/ui.R")

# server
source("server/server.R")

# run
shinyApp(ui = ui,
         server = server)