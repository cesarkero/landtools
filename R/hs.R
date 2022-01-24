#' hs
#'
#' @param r
#'
#' @description 
#' 
#' @return 
#' @export
#'
#' @examples
#' \dontrun{
#' hs(r,40,300)
#' }
# hillshade ( from raster)
hs <- function (r, alt = 30, az = 315) {
    slope = terrain(r, opt='slope')
    aspect = terrain(r, opt='aspect')
    return(hillShade(slope, aspect, alt, az))
}