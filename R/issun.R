#' @title issun
#' 
#' @description Functions to check if time is between sunrise and sunsetfor a 
#' given a layer (zone), date time and time zone
#'  
#' @param layer geographic layer with the obstacles to calculate footprint
#' @param time attribute of the layer that contains the height of the obstacles
#' @param tz time zone (West EU by default)
#' 
#' @examples
#' \dontrun{
#' layer <- casas01
#' issun(layer, "2021-12-21 10:00:00")
#' }
#' 
#' @export

issun <- function(layer, time = "2021-12-21 12:00:00", tz = "Europe/Paris"){
        
        # Create datetimes objects to use in shadow packages
        t = as.POSIXct(time, tz = "Europe/Paris")
        
        # Calculate centroid for geographic coords to use it in shadow
        location = st_centroid(st_union(shp))
        location_geo = sp::spTransform(as_Spatial(location),"+proj=longlat +datum=WGS84")
        
        # Calculate sunrise and sunset
        sunrise <- sunriset(location_geo, t1, direction="sunrise", POSIXct.out=TRUE)$time
        sunset <- sunriset(location_geo, t1, direction="sunset", POSIXct.out=TRUE)$time
        
        if(t > sunrise & t < sunset){
                message('Time is between ',sunrise, ' and ', sunset)
                return(TRUE)
        }else{
                message('Night time --> Time not between ',sunrise, ' and ', sunset)
                return(FALSE)
        }
}

