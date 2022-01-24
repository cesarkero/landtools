#' dir2ovr
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
#' # execute without parallel
#' dir2ovr("./data/raster/MDT25/", "*.asc", FALSE)
#' # execute parallel
#' dir2ovr("./data/raster/MDT25/", "*.asc", TRUE, 12)
#' }
dir2ovr <- function(dir, pattern, parallel=TRUE, ncores=12){
        if (parallel==TRUE){
                files <- normalizePath(list.files(dir, 
                                                  pattern=pattern,
                                                  full.names=T,
                                                  recursive = T)) # list files
                # Limpiar overviews
                for (file in files){gdaladdo(file, clean=TRUE)}
                # Execute in parallel
                cl <- parallel::makeCluster(ncores, type="FORK")
                doParallel::registerDoParallel(cl)
                parLapply(cl, files, function(x){
                        gdaladdo(x, r="average",
                                 ro = TRUE,
                                 levels=c(2,4,8,16),
                                 verbose=TRUE)
                        })
                stopCluster(cl)
        }else{
                files <- normalizePath(list.files(dir,
                                                  pattern=pattern,
                                                  full.names=T,
                                                  recursive = T)) # list files
                # Limpiar overviews
                for (file in files){gdaladdo(file, clean=TRUE)}
                # Generar overviews con archivo externo (ro)
                for (file in files){
                        gdaladdo(file, r="average",
                                 ro = TRUE,
                                 levels=c(2,4,8,16),
                                 verbose=TRUE)
                        } 
        }
}
