% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dir2vrt.R
\name{dir2vrt}
\alias{dir2vrt}
\title{dir2vrt}
\usage{
dir2vrt(dir, outdir, vrtname, pattern)
}
\arguments{
\item{x}{adsfasdf}
}
\value{
VRT
}
\description{
this is a function
}
\examples{
\dontrun{
dir2vrt("./data/raster/MDT25/", "./data/raster/", "MDT25.vrt", "*.asc")
vrt <- paste0("./data/raster/MDT25/", "MDT25.vrt")
mapview(vrt)
}
}
