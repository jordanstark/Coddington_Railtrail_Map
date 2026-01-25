# make web-ready map of railtrail with reports

library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)
library(flexdashboard)


setwd("C:/Users/jorda/Desktop/github/Coddington_Railtrail_Map/")

# prep shape file ------------------------------------------------------------
trail_segments <- read_sf("Railtrail_Segments.shp") %>%
  arrange(Trail_Segm)
trail_latlong <- st_transform(trail_segments, crs = '+proj=longlat +datum=WGS84')


# prep form responses  --------------------------------------------------------
trail_status <- read_csv("C:/Users/jorda/Desktop/FCVRT_trail_responses/20260125_TEST.csv")

seg_stat <- trail_status %>%
  filter(grepl("Section Report",`Submission Type`)) %>%
  select(Timestamp, 
         Trail_Segm = `Trail Segment`,
         `Section Status`)

spot_stat <- trail_status %>%
  filter(grepl("Spot Report",`Submission Type`)) %>%
  select(Timestamp,
         Lat,
         Lon,
         `Type of Spot Report`,
         `Effect on Trail`)
  

# join data for mapping --------------------------------------------------------

trail_layer <- trail_latlong %>%
  left_join(seg_stat) %>%
  mutate(`Section Status` = case_when(is.na(`Section Status`) ~ "Unknown",
                                      TRUE ~ `Section Status`))

spot_layer <- st_as_sf(spot_stat,coords = c("Lon","Lat"),
                       crs = '+proj=longlat +datum=WGS84')



# save leaflet -----------------------------------------------------------------
leaflet(trail_layer) %>%
  addPolygons() %>%
  addMarkers(spot_layer)
  addTiles() %>%
  addDrawToolbar(editOptions = editToolbarOptions()) %>%
  addStyleEditor() %>%
  addScaleBar() %>%
  addMeasure() %>%
  htmlwidgets::saveWidget("Railtrail_Webmap_test.html")
  
