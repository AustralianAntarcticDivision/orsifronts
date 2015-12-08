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

lapply(lapply(txt, splitfr), parsefr)
