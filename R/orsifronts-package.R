#' Orsi fronts.
#'
#' The spatial distributions of the Antarctic Circumpolar Current fronts as presented in
#' Orsi, A. H., T. Whitworth III and W. D. Nowlin, Jr., 1995: On the meridional extent and fronts of the
#' Antarctic Circumpolar Current, Deep-Sea Res. I, 42, 641-673.
#'
#' @format A \link[sp]{SpatialLinesDataFrame} with variables: \code{name}, \code{front}.
#' @importFrom sp SpatialLinesDataFrame Lines Line CRS
"orsifronts"


#' Park/Durand fronts.
#'
#' A dataset containing the locations of the Southern Ocean fronts as determined by Park and Durand.
#'
#' @format A Spatial data frame with five line objects, and the identifiers:
#' \describe{
#'   \item{name}{long name of the front}
#'   \item{front}{short name of the front, abbreviation}
#' }
#' @source \doi{10.17882/59800}
"parkfronts"
