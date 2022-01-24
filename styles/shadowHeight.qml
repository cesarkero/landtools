<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis hasScaleBasedVisibilityFlag="0" version="3.0.3-Girona" maxScale="1000" minScale="1e+8">
  <pipe>
    <rasterrenderer band="1" opacity="0.808" alphaBand="-1" classificationMin="100" type="singlebandpseudocolor" classificationMax="100">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader clip="0" colorRampType="INTERPOLATED" classificationMode="1">
          <colorramp name="[source]" type="gradient">
            <prop k="color1" v="247,251,255,255"/>
            <prop k="color2" v="8,48,107,255"/>
            <prop k="discrete" v="0"/>
            <prop k="rampType" v="gradient"/>
            <prop k="stops" v="0.13;222,235,247,255:0.26;198,219,239,255:0.39;158,202,225,255:0.52;107,174,214,255:0.65;66,146,198,255:0.78;33,113,181,255:0.9;8,81,156,255"/>
          </colorramp>
          <item value="100" color="#08306b" label="100" alpha="255"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0"/>
    <huesaturation grayscaleMode="0" colorizeOn="0" colorizeBlue="128" colorizeGreen="128" colorizeRed="255" colorizeStrength="100" saturation="0"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
