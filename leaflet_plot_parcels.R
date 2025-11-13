# make leaflet map of railtrail

library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)

setwd("C:/Users/jorda/Desktop/github/Coddington_Railtrail_Map/")

trail <- read_sf( "Railtrail_Parcels/Railtrail_Parcels.shp")

trail_latlong <- st_transform(trail, crs = '+proj=longlat +datum=WGS84')

leaflet(trail_latlong) %>%
  addPolygons() %>%
  addTiles() %>%
  addDrawToolbar(editOptions = editToolbarOptions()) %>%
  addStyleEditor() %>%
  addScaleBar() %>%
  addMeasure()%>%
  htmlwidgets::saveWidget("Draft_Railtrail_Interactive_Map_v2.html")
  
