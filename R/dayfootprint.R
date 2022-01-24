#' @title dayfootprint
#' 
#' @description This function craetes a single gpkg with the footprints of 
#' the sun over a layer of buildings (with heigth attribute). The footprints will
#' be calculated from a vector of date-times, created internally. This vector is
#' based in the start time (t1) and stop time (t2) and takes into consideration
#' the possible time restrictions from sunrise and sunset. The solar position will
#' be calculated using the centroid of the layer used.
#' 
#' @param day time to start calculation
#' @param layer geographic layer with the obstacles to calculate footprint
#' @param H attribute of the layer that contains the height of the obstacles
#' @param outdir output folder. A subfolder will be created 
#' @param tz time zone ("Europe/Paris" by default)
#' @param Xmin number of minutes between each calculation
#' @param stylefile path to the style file asociated to the results (not mandatory)
#' 
#' @import maptools
#' 
#' @examples
#' \dontrun{
#' library(landtools)
#' layer <- casas01
#' dayfootprint(layer, day = "2021-12-21", H = "Altura", outdir = "./outputs/", 
#' tz = "Europe/Paris", Xmin = 30, stylefile = "./styles/footprint_azul.qml")
#' }
#' 
#' @export

dayfootprint <- function(layer,
                         day = "2021-12-21",
                         H = "Altura", 
                         outdir = "./outputs/",
                         tz = "Europe/Paris",
                         Xmin = 30,
                         stylefile = "./styles/footprint_azul.qml"){
        
        # Create an output folder
        output <- dodir(paste0(outdir, paste0(gsub('-','',day)), '_footprint','/'))
        
        # Calculate location_geo
        location_geo <- locationgeo(layer)
        
        # Create a list of datetimes
        tis <- dayintervals(location_geo, day, tz, Xmin, TRUE)
        
        #-------------------------------------------------------------------------------
        # Calculate footprints in parallel
        #-------------------------------------------------------------------------------
        # register parallel
        cl <- parallel::makeCluster(detectCores(), type="FORK")
        doParallel::registerDoParallel(cl)
        
        footlist <- foreach(i=seq(1, length(tis))) %dopar% {
                # Calculate solar position
                solar_pos = maptools::solarpos(crds = location_geo, dateTime = tis[[i]])
                
                # Calculate shadowfootprint
                footprint <- shadowFootprint(
                        obstacles = as_Spatial(layer),
                        obstacles_height_field = H,
                        solar_pos = solar_pos
                )
                
                # Add attributes name, time of calculation, sunrise y sunset
                name <- gsub(' ','_',gsub(':','',gsub('-','',toString(tis[[i]]))))
                footprint$Name <- name
                footprint$Hora <- tis[[i]]
                
                # spdf to sf
                st_as_sf(footprint)
        }
        
        stopCluster(cl)
        
        # Join results
        footday <- do.call(rbind, footlist)
        
        # make valid
        footday <- st_make_valid(footday) %>%
                dplyr::mutate(DateTime = as.character(Hora),
                       Hora = str_sub(DateTime, -8, -1)) %>% 
                dplyr::select(DateTime, Hora, Altura)
        
        # Save the footprint in gpkg
        sf::st_write(footday, paste0(output, day,'.gpkg'), append=FALSE)
        
        # Save style
        if (file.exists(stylefile)){
                stylecopy <- paste0(output,paste(day,'.qml',sep=''))
                file.copy(from = stylefile, to = stylecopy)
        }
        
        return(footday)
}
