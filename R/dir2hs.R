#' dir2hs
#'
#' @param x 
#'
#' @description 
#' 
#' @return 
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' }

dir2hs <- function(dir, outdir, pattern, ncores = 12, alt = 30, az = 315){
        # get files (dem,dsm...)
        files <- normalizePath(list.files(dir,
                                          pattern=pattern,
                                          full.names=T,
                                          recursive = T)) # list files
        # set output folder
        noutdir <- dodir(outdir)
        
        # Execute in parallel
        cl <- parallel::makeCluster(ncores, type="FORK")
        doParallel::registerDoParallel(cl)
        parLapply(cl, files, function(x){
                n <-file_path_sans_ext(basename(x))
                name <- paste0(noutdir, n, '.tif')
                writeRaster(hs(raster(x),alt=alt, az = az), name, overwrite = TRUE)
        })

        #
        stopCluster(cl)
}