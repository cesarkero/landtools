#' @title locationgeo
#' 
#' @description creates a single points layer with the centroid in geographic coords
#' usable by shadow package as location for sun position
#'  
#' @param layer geographic layer with the obstacles to calculate footprint
#' 
#' @examples
#' \dontrun{
#' layer <- casas01
#' mapview(locationgeo(layer), color='red')+layer
#' }
#' 
#' @export

locationgeo <- function(layer){
        # Set layer without z (if exist)
        shp <- st_zm(layer)
        
        # Calculate centroid for geographic coords to use it in shadow
        location = st_centroid(st_union(shp))
        location_geo = sp::spTransform(as_Spatial(location),"+proj=longlat +datum=WGS84")
        
        return(location_geo)
}

