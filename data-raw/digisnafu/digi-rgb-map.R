a <- "https://images.theconversation.com/files/245093/original/file-20181112-83564-xa6jev.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1000&fit=clip"

curl::curl_download(a, file.path("data-raw/digisnafu/file-20181112-83564-xa6jev.jpg"))
f <- "data-raw/digisnafu/file-20181112-83564-xa6jev.jpg"
r <- raster::brick(f)
library(affinething)
#aa <- affinething(r, rgb = TRUE)

aa <- structure(c(364.085667215815, 626.853377265239, 512.850082372323,
                  665.07413509061), .Dim = c(2L, 2L), .Dimnames = list(NULL, c("x",
                                                                               "y")))

library(raster)
prj <-  "+proj=stere +lat_0=-90 +lat_ts=-67  +datum=WGS84"
ex <- domath(matrix(c(-120, 60, -67, -67), 2),
       aa, r = r, proj = prj)

b <- setExtent(r, ex)
projection(b) <- prj
plotRGB(b)
library(SOmap)
SOcrs(prj)
SOplot(w)
plot(spTransform(w, prj))
g <- graticule::graticule(seq(-180, 175, by = 15), c(-70, -67, -60), proj = prj)
plot(g, add = TRUE)


writeRaster(b, "data-raw/digisnafu/fronts.tif")
