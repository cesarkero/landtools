#' @title dftopoints
#' @author 
#' @description get a data.frame with lon lat and creates an spatial object converting CRS
#' 
#' @param df data.frame with coords in attributes
#' @param epsg1 is the epsg from origin in format "EPSG:00000" ("EPSG:4326" by default)
#' @param epsg2 the epsg fro transformation if needed, in format "EPSG:00000" ("EPSG:25829" by default)
#' @param AtriCoords vector with the names of the attributes with "lon" and "lat" values (in that order)
#' 
#' @export
dftopoints <- function(df,
                       epsg1 = "EPSG:4326",
                       epsg2 = "EPSG:25829", AtriCoords = c("lon","lat")){

        proj1 = sp::CRS(paste0("+init=", epsg1))
        proj2 = sp::CRS(paste0("+init=", epsg2))
        
        # df coords to numeric
        df[AtriCoords[[1]]] <- as.numeric(unlist(df[AtriCoords[[1]]]))
        df[AtriCoords[[2]]] <- as.numeric(unlist(df[AtriCoords[[2]]]))
        
        #create spatial objec from coords
        sp::coordinates(df) <- AtriCoords
        sp::proj4string(df) <- proj1
        sdf <- sp::spTransform(df,proj2) #change CRS
        sdf$X <- sdf@coords[,1] #add coords to table
        sdf$Y <- sdf@coords[,2] #add coords to table
        
        #output
        return(st_as_sf(sdf))
}
