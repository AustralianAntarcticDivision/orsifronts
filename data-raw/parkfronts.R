## TODO: attribution properly
# Ressource 59800 - Park Young-Hyang, Durand Isabelle (2019). Altimetry-drived Antarctic Circumpolar Current fronts. SEANOE. https://doi.org/10.17882/59800
#
# Requested file :
#   Nom	Id
# Geographical positions of five altimetry-derived fronts of the Antarctic Circumpolar Current	62985


#https://github.com/AustralianAntarcticDivision/SOmap/blob/268082ec6ababf368171051480c82b353a1f8b58/data-raw/ACCFronts.R

parkfronts <- readRDS("../SOmap/data-raw/fronts_park.rds")
parkfronts <- sf::as_Spatial(parkfronts)
usethis::use_data(parkfronts)
