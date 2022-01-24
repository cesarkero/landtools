library(lidR)
library(sf)
library(future)
library(mapview)
library(doParallel)
library(stringr)
library(landtools)

#-------------------------------------------------------------------------------
# CALCULAR TIEMPO
system.time({
#-------------------------------------------------------------------------------
    
# Parámetros
# cliplayer <- st_read("/media/cesarkero/D1/GDrive/Proyectos/ModlEarth/03_Tools/EIIP/Blender/layers/CLIPLAYERS/CLIP.gpkg")
# save(cliplayer, file="./data/cliplayer.RData")
data("cliplayer") # ojo solo si se va a utilizar como ejemplo la capa de corte de la librería, si no cargar una en cliplayer
cliplayer <- st_read('/media/cesarkero/D1/GDrive/Proyectos/ModlEarth/02_Proyectos/2021/ADA2021_031_EIIP-mns_PE_AM/03_Trabajo/01_Fuentes/Buffer_1km.shp')

lasdir <- "/media/cesarkero/T/SIG/_10_LIDAR_CNIG/LIDAR_2_CNIG/Galicia/"
buffer = 0
res = 1
outdir <- "/media/cesarkero/D1/GDrive/Proyectos/ModlEarth/02_Proyectos/2021/ADA2021_031_EIIP-mns_PE_AM/03_Trabajo/03_Resultados/LIDAR_MODELS/"

#-------------------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# PROCESS
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# Create realoutdir for res
outdir <-  dodir(paste0(outdir, 'LIDAR_', str_pad(res, 3,"left",'0'), '/'))

#-------------------------------------------------------------------------------
# CATALOG
# Process cat or read cat
if (file.exists("cat.rds")){
    cat <- readRDS("./temp/cat.rds")
} else {
    cat <- readLAScatalog(lasdir, progress = TRUE, recursive = TRUE, pattern = '*COL.laz$|*COL.LAZ$', full.names = TRUE)
    saveRDS(cat,"./temp/cat.rds")
}

# opciones de procesamiento del catálogo
projection(cat) <- "+init=epsg:25829"
opt_progress(cat) <- TRUE #see progress
opt_laz_compression(cat) <- TRUE #laz compression
opt_filter(cat) <- "-keep_first -drop_z_below 0"
opt_chunk_buffer(cat) <- 100 #superposicion de retile
opt_chunk_size(cat) <- 0 #dimensiones del retile
cat@output_options$drivers$Raster$param$overwrite <- TRUE # permite sobreescribir los archivos intermedios

#-------------------------------------------------------------------------------
# clip del catálogo al área de estudio
catalog_select(cat,mapview=TRUE) # Esto sirve para seleccionar por mapa

# capa de corte a partir de buffer
AMB <- st_as_sf(st_buffer(st_union(rbind(cliplayer, cliplayer)), buffer))
spcat <- as.spatial(cat)
cat$processed <- rgeos::gIntersects(as_Spatial(AMB), spcat, byid = TRUE)
# plot(cat)

#-------------------------------------------------------------------------------
# SET PARALLEL
# set working in parallel
plan(multisession, workers = 12L)
set_lidr_threads(12L)

#-------------------------------------------------------------------------------
# BIG PRORCESS 
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# MDT
MDT.dir <- dodir(paste0(outdir,"/MDT/"))
# MDT PROCESS (FUNCIONA) - Exportará también los mdt internemdios al outdir
opt_output_files(cat) <- paste0(MDT.dir,"{ORIGINALFILENAME}") #set filepaths
# MDT <- grid_terrain(cat, res = res, algorithm = tin())
MDT <- grid_terrain(cat, res = res, algorithm = "knnidw"(k = 5, p = 2))

#-------------------------------------------------------------------------------
# MDS
MDS.dir <- dodir(paste0(outdir,"/MDS/"))
opt_output_files(cat) <- paste0(MDS.dir,"{ORIGINALFILENAME}") #set filepaths
MDS <- grid_canopy(cat, res = res, pitfree(c(0,2,5,10,15), c(0, res))) # this doesn't filter overliers values

#-------------------------------------------------------------------------------
# MDS_ED
MDS_ED.dir <- dodir(paste0(outdir,"/MDS_ED/"))
opt_output_files(cat) <- paste0(MDS_ED.dir,"{ORIGINALFILENAME}") #set filepaths
MDS_ED <- grid_terrain(cat, res = res, algorithm = "knnidw"(k = 5, p = 2), use_class = c(2L,6L,9L))

#-------------------------------------------------------------------------------
# Calcular MDE --> Altura de todos los elementos
MDE <- MDS-MDT
MDE.dir <- dodir(paste0(outdir,"/MDE/"))
writeRaster(MDE, paste0(MDE.dir,"MDE.tif"), overwrite=TRUE)

#-------------------------------------------------------------------------------
# Calcular MDE_ED --> Altura de edificación
MDE_ED <- MDS_ED-MDT
MDE_ED.dir <- dodir(paste0(outdir,"/MDE_ED/"))
writeRaster(MDE_ED,paste0(MDE_ED.dir,"MDE_ED.tif"), overwrite=TRUE)

#-------------------------------------------------------------------------------
future:::ClusterRegistry("stop")
#-------------------------------------------------------------------------------
# CERRAR TIEMPO
})

#-------------------------------------------------------------------------------
# HILLSHADES
#-------------------------------------------------------------------------------
# MDT_HS
MDT_HS.dir <- dodir(paste0(outdir,"/MDT_HS/"))
# dir2hs(MDT.dir, MDT_HS.dir, '*.tif$', 12)
# dir2ovr(MDT_HS.dir, '*.tif$')
# dir2vrt(MDT_HS.dir, MDT_HS.dir, 'MDT_HS.vrt', '*.tif$')
# HS COMPLETO
MDT_HS <- hs(MDT)
writeRaster(MDT_HS, paste0(MDT_HS.dir, "MDT_HS.tif"))

# MDS_HS
MDS_HS.dir <- dodir(paste0(outdir,"/MDS_HS/"))
# dir2hs(MDS.dir, MDS_HS.dir, '*.tif$', 12)
# dir2ovr(MDS_HS.dir, '*.tif$')
# dir2vrt(MDS_HS.dir, MDS_HS.dir, 'MDS_HS.vrt', '*.tif$')
# HS COMPLETO
MDS_HS <- hs(MDS)
writeRaster(MDS_HS, paste0(MDS_HS.dir, "MDS_HS.tif"))

# MDS_ED_HS
MDS_ED_HS.dir <- dodir(paste0(outdir,"/MDS_ED_HS/"))
# dir2hs(MDS_ED.dir, MDS_ED_HS.dir, '*.tif', 12)
# dir2ovr(MDS_ED_HS.dir, '*.tif$')
# dir2vrt(MDS_ED_HS.dir, MDS_ED_HS.dir, 'MDS_ED_HS.vrt', '*.tif$')
# HS COMPLETO
MDS_ED_HS <- hs(MDS_ED)
writeRaster(MDS_ED_HS, paste0(MDS_ED_HS.dir, "MDS_ED_HS.tif"))

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# CLIPEAR LOS RESULTADOS PARA UN ÁREA CONCREATA
#-------------------------------------------------------------------------------
out <- dodir(paste0(outdir,"/00_CLIP/"))

A <- raster(paste0(outdir,"/MDT/grid_terrain.vrt"))
B <- raster(paste0(outdir,"/MDT_HS/MDT_HS.tif"))
C <- raster(paste0(outdir,"/MDS/grid_canopy.vrt"))
D <- raster(paste0(outdir,"/MDS_HS/MDS_HS.tif"))
E <- raster(paste0(outdir,"/MDS_ED/grid_terrain.vrt"))
F <- raster(paste0(outdir,"/MDS_ED_HS/MDS_ED_HS.tif"))
G <- raster(paste0(outdir,"/MDE/MDE.tif"))
H <- raster(paste0(outdir,"/MDE_ED/MDE_ED.tif"))

rlist <- c(A,B,C,D,E,F,G,H)

# register parallel
cl <- parallel::makeCluster(detectCores()-1, type="FORK")
doParallel::registerDoParallel(cl)

rclips <- foreach(i=seq(1, length(rlist))) %dopar% {return(raster::mask(rlist[[i]], cliplayer))}

# stop parallel
stopCluster(cl)

# Export each raster to a location
n <- c("MDT.tif", "MDT_HS.tif", "MDS.tif", "MDS_HS.tif", "MDS_ED.tif", "MDS_ED_HS.tif","MDE.tif", "MDE_ED.tif")
for(i in 1:length(rclips)){writeRaster(rclips[[i]], file=paste0(out, n[i]), overwrite = TRUE)}
