#' @title addrasterval
#' @author cesarkero
#' 
#' @description the function extract raster value for sf layer. If the layer is 
#' a layer of points --> extract values, if it is a polygon layer it extract the mean value
#' 
#' @param x sf layer of points or polygons (not yet tested with lines)
#' @param r raster layer (must be in the same CRS as layer)
#' @param par if TRUE --> parallel computation
#' @param dec number of decimals of the value extracted
#' @param rvalname name of the attribute with the raster values
#' 
#' @export
addrasterval <- function(x, r, par = TRUE, dec = 0, rvalname = 'Cota'){
        
        if(st_geometry_type(points, by_geometry = FALSE)=='POINT'){
                cotas <- raster::extract(r, as_Spatial(x), na.rm=TRUE, df=TRUE)
                x[rvalname] <- round(cotas[,2], dec)
        } else {
                if(par == TRUE){
                        cores = detectCores()
                        # Create subseting numbers
                        n <- nrow(x)
                        reps <- rep(1:ceiling(n/cores), each = ceiling(n/cores))[1:n]
                        dflist <- split(x, reps)
                        
                        # Crop rasters in parallel
                        cl <- parallel::makeCluster(cores, type="FORK")
                        doParallel::registerDoParallel(cl)
                        dfs <- foreach(i = 1:length(dflist)) %dopar% {
                                d <- dflist[[i]]
                                cotas <- raster::extract(r, as_Spatial(d),
                                                         fun = mean, na.rm=TRUE, df=TRUE)
                                round(cotas[,2], dec)
                                d
                        }
                        stopCluster(cl)
                        
                        # Merge all
                        x <- do.call(rbind, dfs)
                        
                } else {
                        cotas <- raster::extract(r, as_Spatial(x), na.rm=TRUE, df=TRUE)
                        x[rvalname] <- round(cotas[,2], dec)
                }
                
        }
        
        return(x)
}
