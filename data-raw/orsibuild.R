u <- "http://woceatlas.tamu.edu/Sites/zip/atlas/fronts.zip"
download.file(u, file.path("data-raw", basename(u)), mode = "wb")
unzip(file.path("data-raw", basename(u)), exdir = "data-raw")

frontnames <- structure(c("Subtropical front", "Subantarctic front", "Polar front",
                      "Southern Antarctic circumpolar current front", "Southern Boundary of the Antarctic circumpolar current"), .Names = c("stf", "saf", "pf", "saccf", "sbdy"))

splitfr <- function(x) {
  m <- grepl("%", x)
  ind <- c(0, cumsum(abs(diff(m))))
  x <- x[!m]
  ind <- ind[!m]
  split(x, ind)
}

parsefr <- function(x) {
  lapply(x, function(y) Line(as.matrix(read.table(text = y, colClasses = "numeric"))))
}

txt <- lapply(names(frontnames), function(x) readLines(sprintf("data-raw/%s.txt", x)))

pnum <- lapply(lapply(txt, splitfr), parsefr)

orsifronts <- SpatialLinesDataFrame(
  SpatialLines(lapply(seq_along(pnum), function(x) Lines(pnum[[x]], names(frontnames)[x])), proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")),
  data.frame(name = frontnames, front = names(frontnames), row.names = names(frontnames), stringsAsFactors = FALSE))

save(orsifronts, file = "data/orsifronts.rdata")
