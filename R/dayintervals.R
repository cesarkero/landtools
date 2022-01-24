#' @title dayintervals
#' 
#' @description This functions creates a list of date times for a whole day
#' between sunrise and sunset
#' 
#' @param t1 time to iniciate --> format --> "2021-12-21 05:00:00"
#' @param t2 time to stop --> forma --> "2021-12-21 05:00:00"
#' @param s1 sunrise (must be calculated from geographic coords)
#' @param s2 sunset (must be calculated from geographic coords)
#' @param cadaXmin number of minutes between each calculus
#' @param sunrisesunset if TRUE --> include sunrise and sunset in the final vector
#' 
#' @examples
#' \dontrun{
#' layer <- casas01
#' location_geo <- locationgeo(layer)
#' dayintervals(location_geo, day='2021-08-24', Xmin=30)
#' }
#' 
#' @export

dayintervals <- function(location_geo, day='2021-12-21', tz = "Europe/Paris",
                         Xmin=30, sunrisesunset = TRUE){
        # day to datetime
        t1 = as.POSIXct(day, tz)
        
        # Calculate sunrise and sunset
        s1 <- sunriset(location_geo, t1, direction="sunrise", POSIXct.out=TRUE)$time
        s2 <- sunriset(location_geo, t1, direction="sunset", POSIXct.out=TRUE)$time
        
        # Create intervals iteratively
        s <- Xmin*60
        tis <- list()
        index <- 1
        while (t1<=s2) {
                if (t1<=s1){
                        t1=t1+s
                }else{
                        tis[[index]] <- t1
                        t1 = t1+s
                        index <- index+1  
                }
        }
        
        if(sunrisesunset==TRUE){
                # añadir sunrise y sunset a la lista de cálculo
                if(!s1 %in% tis){tis <- append(tis, list(s1+600),0)}
                if(!s2 %in% tis){tis <- append(tis, list(s2-600))}
        }
        
        return(tis)
}
