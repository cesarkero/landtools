#' dir2vrt
#'
#' @param x adsfasdf
#'
#' @description this is a function
#' 
#' @return VRT
#' @export
#'
#' @examples
#' \dontrun{
#' dir2vrt("./data/raster/MDT25/", "./data/raster/", "MDT25.vrt", "*.asc")
#' vrt <- paste0("./data/raster/MDT25/", "MDT25.vrt")
#' mapview(vrt)
#' }
dir2vrt <- function(dir, outdir, vrtname, pattern){
        files <- normalizePath(list.files(dir,
                                          pattern=pattern,
                                          full.names=T,
                                          recursive = T)) # list files
        outvrt <-  paste0(normalizePath(outdir), '/', vrtname) # set output name
        gdalbuildvrt(gdalfile = files,
                     output.vrt= outvrt,
                     intern = TRUE,
                     overwrite = TRUE,
                     allow_projection_difference=TRUE)
}
