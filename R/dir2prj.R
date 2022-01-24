#' prj2dir
#'
#' @param x adsfasdf
#'
#' @description add a .prj file to each of the rasters within a dir 
#' All the rasters must have the same projection
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
prj2dir <- function(prjfile, dir, pattern){
        # list files
        files <- normalizePath(list.files(dir,
                                          pattern=pattern,
                                          full.names=T,
                                          recursive = T)) # list files
        
        #basename without extension with tools library
        s<-file_path_sans_ext(basename(files))
        
        # prj files
        prjs <- paste0(s,'.prj')
        
        # set newdir (in case dir have been checked recursively)
        ndir <- fpath(files)
        
        for(i in seq(prjs)){
                # i <- 30
                nprjfile <- paste0(ndir,prjs[[i]])
                # if the file don't exist --> create it
                if(!file.exists(nprjfile)){
                        file.copy(prjfile, nprjfile) #copy files
                }
        }
}
