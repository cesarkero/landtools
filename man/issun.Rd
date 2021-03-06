% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/issun.R
\name{issun}
\alias{issun}
\title{issun}
\usage{
issun(layer, time = "2021-12-21 12:00:00", tz = "Europe/Paris")
}
\arguments{
\item{layer}{geographic layer with the obstacles to calculate footprint}

\item{time}{attribute of the layer that contains the height of the obstacles}

\item{tz}{time zone (West EU by default)}
}
\description{
Functions to check if time is between sunrise and sunsetfor a 
given a layer (zone), date time and time zone
}
\examples{
\dontrun{
layer <- casas01
issun(layer, "2021-12-21 10:00:00")
}

}
