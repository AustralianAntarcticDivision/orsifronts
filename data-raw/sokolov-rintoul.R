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
#plot(srfronts, col = bpy.colors(nrow(srfronts)))
#library(maps)
#map("world2", add = TRUE)

devtools::use_data(srfronts)
#devtools::install_github("tidyverse/ggplot2")
# library(ggplot2)
# library(sf)
# ggplot(st_as_sf(srfronts)) + 
#   geom_sf(aes(colour = front)) + 
#   coord_sf( crs = "+proj=stere +lat_0=-90 +datum=WGS84")



yfiles <- tibble::tibble(fullname = list.files("data-raw/sokolov-rintoul-source/yearly", full.names = TRUE, pattern = "mat$"))
x <- R.matlab::readMat(yfiles$fullname[1])
## this loses the object level grouping so need to unpick that a bit more
lon <- dplyr::bind_rows(unlist(rapply(x$Fronts[[1]], 
                                      classes = "matrix", 
                                      f = function(y) tibble::tibble(x = as.vector(y)), 
                                      how = "replace"), recursive = FALSE), 
                        .id = "blah")
lat <- dplyr::bind_rows(unlist(rapply(x$Fronts[[2]], classes = "matrix", f = function(y) tibble::tibble(y = as.vector(y)), how = "replace"), recursive = FALSE), .id = "blah")

d <- bind_cols(lon, lat %>% select(-blah))
ggplot(d, aes(x, y, group = blah, colour  = blah)) + geom_path() + guides(colour = FALSE)

