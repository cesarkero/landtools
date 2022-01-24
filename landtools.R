library(landtools)
library(raster)
library(mapview)

#-------------------------------------------------------------------------------
# Add prj to directory of rasters
dir <- "/media/cesarkero/T/SIG/_00_Base/MDT005/Galicia/"
prjfile <- "/media/cesarkero/T/SIG/PRJ/PRJ_25829.prj"
pattern = "*.asc$"

dir2prj(prjfile, dir, pattern)

#-------------------------------------------------------------------------------
# Export all rasters to .tif
dir <- "/media/cesarkero/T4/SIG/_00_Base/_09_MDT_IET_Gal_2018/MDT001/Descargas/"
outdir = "/media/cesarkero/T4/SIG/_00_Base/_09_MDT_IET_Gal_2018/MDT001/" 
pattern = "*.img$"

dir2tif(dir,outdir,pattern, 10) # creará una subcarpeta TIF

#-------------------------------------------------------------------------------
# crear vrt
dir <- "/media/cesarkero/T4/SIG/_00_Base/_08_MDS_IET_Gal_2018/MDS001/"
outdir = "/media/cesarkero/T4/SIG/_00_Base/_08_MDS_IET_Gal_2018/"
vrtname = "MDS001.vrt"
pattern = "*.img$"

dir2vrt(dir, outdir, vrtname, pattern)
vrt <- raster(paste0(outdir, vrtname))
mapview(vrt)

#-------------------------------------------------------------------------------
# crear piramides
dir <- "/media/cesarkero/T/SIG/_00_Base/MDT005/Galicia/TIF/"
pattern = "*.tif$"
dir2pir(dir, pattern,TRUE, 12)

#-------------------------------------------------------------------------------
# crear HS
dir <- "/media/cesarkero/T/SIG/_00_Base/MDT005/Galicia/"
outdir = "/media/cesarkero/T/SIG/_00_Base/MDT005/Galicia/"
vrtname = "MDT005_HS.vrt"
pattern = "*.tif$"

dir2hs(dir,outdir,pattern)
dir2pir(paste0(dir,'HS'), "*.tif$", TRUE, 12)
dir2vrt(paste0(dir,'HS'), outdir, vrtname, pattern)

#-------------------------------------------------------------------------------
# CLIPEAR DEM
library(sf)
library(dplyr)
library(raster)
shp <- st_read("/media/cesarkero/D1/GDrive/Proyectos/ModlEarth/03_Tools/EIIP/Viewsheds/capas/CA/CA.shp")
dem <- raster('/media/cesarkero/T/SIG/_00_Base/MDT005/Galicia/MDT005.vrt')

# dissolve Galicia + Asturas + Castilla y León
# shp$NAMEUNIT # check results
shpfilter <- shp %>% filter(NAMEUNIT %in% c("Galicia","Principado de Asturias"))

# dissolve selected comunitie
cliper <- st_union(shpfilter)

# clip raster
n <- '/media/cesarkero/D1/GDrive/Proyectos/ModlEarth/03_Tools/EIIP/Viewsheds/capas/MDT05/MDT05.tif'
demx <- mask(dem, st_as_sf(cliper), filename=n)
