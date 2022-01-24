#' @title simplefootprint
#' 
#' @description This function craetes a single gpkg with the footprints of 
#' the sun over a layer of buildings (with heigth attribute). The footprints will
#' be calculated from a vector of date-times, created internally. This vector is
#' based in the start time (t1) and stop time (t2) and takes into consideration
#' the possible time restrictions from sunrise and sunset. The solar position will
#' be calculated using the centroid of the layer used.
#' 
#' @param layer geographic layer with the obstacles to calculate footprint
#' @param heighattr attribute of the layer that contains the height of the obstacles
#' @param outdir output folder. A subfolder will be created 
#' @param time1 time to start calculation
#' @param time2 time to stop calculation
#' @param tz time zone ("Europe/Paris" by default)
#' @param stylefile path to the style file asociated to the results (not mandatory)
#' @param cadaXmin number of minutes between each calculation
#' 
#' @import maptools
#' 
#' @examples
#' \dontrun{
#' layer <- casas01
#' x <- simplefootprint(layer, time = "2021-12-21 10:00:00")
#' mapview(x)
#' }
#' 
#' @export

simplefootprint <- function(layer, heightattr="Altura", 
                         outdir = "./outputs/",
                         time = "2021-12-21 12:00:00",
                         tz = "Europe/Paris"){
        
        # Create datetimes objects to use in shadow packages
        t = as.POSIXct(time, tz = "Europe/Paris")
        day <- substr(gsub('-','',toString(t)),1,8)
        
        # Set layer without z (if exist)
        shp <- st_zm(layer)
        
        # Calculate centroid for geographic coords to use it in shadow
        location = st_centroid(st_union(shp))
        location_geo = sp::spTransform(as_Spatial(location),"+proj=longlat +datum=WGS84")
        
        # Calculate sunrise and sunset
        sunrise <- sunriset(location_geo, t1, direction="sunrise", POSIXct.out=TRUE)$time
        sunset <- sunriset(location_geo, t1, direction="sunset", POSIXct.out=TRUE)$time
        
        # If time is between sunrise and sunset --> calculate
        # Otherwise --> stop
        if(issun(layer, time, tz)){
                #-------------------------------------------------------------------------------
                # Calculate footprints in parallel
                #-------------------------------------------------------------------------------
                # Calculate solar position
                solar_pos = maptools::solarpos(crds = location_geo, dateTime = t)
                
                # Calculate shadowfootprint
                footprint <- shadowFootprint(
                        obstacles = as_Spatial(shp),
                        obstacles_height_field = heightattr,
                        solar_pos = solar_pos
                )
                
                # Add attributes name, time of calculation, sunrise y sunset
                nombre <- gsub(' ','_',gsub(':','',gsub('-','',toString(t))))
                footprint$Name <- nombre
                footprint$Day <- day 
                footprint$Datetime <- t
                footprint$sunrise <- sunrise
                footprint$sunset <- sunrise
                footprint <- st_as_sf(footprint)
                
        }else{
                footprint <- NA
        }
        
        # return layer
        return(footprint)
}

