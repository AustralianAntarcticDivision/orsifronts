library(dplyr)
files <- tibble::tibble(fullname = list.files("data-raw/sokolov-rintoul-source", full.names = TRUE)) %>% 
  filter(!basename(fullname) %in% c("Readme", "yearly"))

## raw coordinate data, grouped by X1 and filename
d <- purrr::map_df(files$fullname, readr::read_table, col_names = FALSE, .id  = "file") %>% 
  mutate(filename = basename(files$fullname)[as.integer(file)]) %>% dplyr::select(-file)

d <- d %>% rename(x_ = X1, y_ = X2, object_ = filename, branch_ = X3) %>% 
  mutate(order_ = row_number())
library(spbabel)
srfronts <- sp(d, attr_tab = d %>% transmute(front = object_) %>% distinct(), crs = "+init=epsg:4326")
plot(srfronts, col = bpy.colors(nrow(srfronts)))
library(maps)
map("world2", add = TRUE)

devtools::use_data(srfronts)
#devtools::install_github("tidyverse/ggplot2")
# library(ggplot2)
# library(sf)
# ggplot(st_as_sf(srfronts)) + 
#   geom_sf(aes(colour = front)) + 
#   coord_sf( crs = "+proj=stere +lat_0=-90 +datum=WGS84")
