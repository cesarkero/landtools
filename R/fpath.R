#' fpath
#'
#' @param x adsfasdf
#'
#' @description get the folder of a file or folderpath
#' 
#' @return string (dir)
#' @export
#'
#' @examples
#' \dontrun{
#' fpath("./path/file.tif")
#' }
#' @export

fpath <- function(path) {
        x <- setdiff(strsplit(path,"/|\\\\")[[1]], "")
        return(paste0('/',paste(x[-length(x)], collapse = "/"),"/"))
}
