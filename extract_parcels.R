# extract parcels associated with railtrail
# and resave

library(tidyverse)
library(sf)

setwd("/c")

## parcel list
parc <- c("503089-48.-1-13.21",
          "503089-47.-2-7",
          "502489-71.-1-25",
          "502489-71.-1-28",
          "502200-5.-1-13",
          "502000-14.-1-16",
          "502000-15.-1-3",
          "502000-24.-1-9",
          "502000-25.-1-3",
          "502000-33.-1-7")

all_shp <- read_sf("")