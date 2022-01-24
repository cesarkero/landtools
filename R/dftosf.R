#DFtoPoints
#get a data.frame with lon lat and creates an spatial object converting CRS
dftosf <- function(df,
                   epsg1 = 4326,
                   epsg2 = 25829, lonlat = c("lon","lat")){
    
    # Correct the df to remove NA values (must be corrected in future)
    df <- df %>% filter(!(is.na(df$lon) | is.na(df$lat)))
    
    # Compose the epsg
    epsg1 = sp::CRS(paste0("+init=epsg:", toString(epsg1)))
    epsg2 = sp::CRS(paste0("+init=epsg:", toString(epsg2)))
    
    #create spatial objec from coords
    sp::coordinates(df) <- lonlat
    sp::proj4string(df) <- epsg1
    sdf <- sp::spTransform(df,epsg2) #change CRS
    sdf$x <- sdf@coords[,1] #add coords to table
    sdf$y <- sdf@coords[,2] #add coords to table
    
    #output
    return (st_as_sf(sdf))
}
