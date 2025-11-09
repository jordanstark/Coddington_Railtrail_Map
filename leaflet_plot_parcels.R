# make leaflet map of railtrail

library(tidyverse)
library(sf)
library(leaflet)

setwd("C:/Users/jorda/Desktop/github/Coddington_Railtrail_Map/")

trail <- read_sf( "Railtrail_Parcels/Railtrail_Parcels.shp")

trail_latlong <- st_transform(trail, crs = '+proj=longlat +datum=WGS84')

leaflet(trail_latlong) %>%
  addPolygons() %>%
  addTiles() %>%
  htmlwidgets::saveWidget("Draft_Railtrail_Interactive_Map.html")
  
