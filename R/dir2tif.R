#' dir2tif
#'
#' @param x 
#'
#' @description converts all rasters to .tif
#' 
#' @return 
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' }
dir2tif <- function(dir, outdir, pattern, ncores = 6){
        # get files (dem,dsm...)
        lfiles <- list.files(dir,pattern=pattern,full.names=T,recursive = T) # list files
        files <- normalizePath(lfiles)
        # set output folder
        todir <- function(dir){if (!dir.exists(dir)){dir.create(dir)}; return(dir)}
        noutdir <- todir(paste0(outdir,'TIF','/'))
        
        # Execute in parallel
        cl <- parallel::makeCluster(ncores, type="FORK")
        doParallel::registerDoParallel(cl)
        parLapply(cl, files, function(x){
                n <-file_path_sans_ext(basename(x))#basename without extension with tools library
                name <- paste0(noutdir, n, '.tif')
                writeRaster(raster(x), name, overwrite = TRUE)
        })
        stopCluster(cl)
}