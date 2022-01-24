#' dodir
#'
#' @param path
#'
#' @description This function sets a dir name and create the folder if doesn't exist
#' The penultimate folder must exist ¡¡
#' 
#' @return string
#' @export
#'
#' @examples
#' \dontrun{
#' dodir("./ei/ou/")
#' }
#' @export

dodir <- function(path, removeall = FALSE){
        # set directory and create if don't exists
        if (!dir.exists(path)){
                cat('Created --> ', path, '\n\n')
                dir.create(path)
        }else{
                if(removeall == FALSE){
                        cat('Folder already exist --> ', path, '\n\n')
                        cat('To remove completely the folter use \'removeall = TRUE\'', '\n\n')
                }else{
                        cat('Removing and creating a new output --> ', path, '\n\n')
                        unlink(path, recursive=FALSE)
                }
        }
        return(path)
}
