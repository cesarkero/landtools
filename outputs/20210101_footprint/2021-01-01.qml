<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.0.3-Girona" simplifyMaxScale="1" readOnly="0" hasScaleBasedVisibilityFlag="0" simplifyAlgorithm="0" labelsEnabled="0" simplifyDrawingTol="1" simplifyLocal="1" maxScale="0" minScale="1e+8" simplifyDrawingHints="1">
  <renderer-v2 type="RuleRenderer" symbollevels="0" forceraster="0" enableorderby="0">
    <rules key="{61bd0786-81f6-48e4-bbbc-61a0ba3b139f}">
      <rule symbol="0" key="{09f584aa-37ff-46da-a496-9e42375cdd9c}"/>
      <rule filter=" &quot;Cota&quot;  =  86 " label="Nave" symbol="1" key="{7941b024-6730-4dfa-b3b4-b72546d76c11}"/>
    </rules>
    <symbols>
      <symbol name="0" type="fill" alpha="0.490196" clip_to_extent="1">
        <layer class="SimpleFill" pass="0" locked="0" enabled="1">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="31,120,180,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="0,0,0,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol name="1" type="fill" alpha="0.5" clip_to_extent="1">
        <layer class="SimpleFill" pass="0" locked="0" enabled="1">
          <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="color" v="255,0,4,255"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.26"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="style" v="solid"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <customproperties>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer attributeLegend="1" diagramType="Histogram">
    <DiagramCategory scaleDependency="Area" penWidth="0" opacity="1" labelPlacementMethod="XHeight" diagramOrientation="Up" penAlpha="255" maxScaleDenominator="1e+8" penColor="#000000" sizeType="MM" enabled="0" minScaleDenominator="0" sizeScale="3x:0,0,0,0,0,0" height="15" barWidth="5" lineSizeScale="3x:0,0,0,0,0,0" scaleBasedVisibility="0" width="15" backgroundAlpha="255" backgroundColor="#ffffff" lineSizeType="MM" minimumSize="0" rotationOffset="270">
      <fontProperties description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style=""/>
      <attribute color="#000000" label="" field=""/>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings showAll="1" placement="0" priority="0" dist="0" obstacle="0" linePlacementFlags="2" zIndex="0">
    <properties>
      <Option type="Map">
        <Option value="" name="name" type="QString"/>
        <Option name="properties"/>
        <Option value="collection" name="type" type="QString"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <fieldConfiguration>
    <field name="SHAPE_AREA">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="MDEcota6__">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="Cota">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="Hora">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="sunrise">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="sunset">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="SHAPE_AREA" index="0"/>
    <alias name="" field="MDEcota6__" index="1"/>
    <alias name="" field="Cota" index="2"/>
    <alias name="" field="Hora" index="3"/>
    <alias name="" field="sunrise" index="4"/>
    <alias name="" field="sunset" index="5"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default expression="" applyOnUpdate="0" field="SHAPE_AREA"/>
    <default expression="" applyOnUpdate="0" field="MDEcota6__"/>
    <default expression="" applyOnUpdate="0" field="Cota"/>
    <default expression="" applyOnUpdate="0" field="Hora"/>
    <default expression="" applyOnUpdate="0" field="sunrise"/>
    <default expression="" applyOnUpdate="0" field="sunset"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="SHAPE_AREA" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="MDEcota6__" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="Cota" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="Hora" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="sunrise" unique_strength="0"/>
    <constraint notnull_strength="0" constraints="0" exp_strength="0" field="sunset" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="SHAPE_AREA" desc=""/>
    <constraint exp="" field="MDEcota6__" desc=""/>
    <constraint exp="" field="Cota" desc=""/>
    <constraint exp="" field="Hora" desc=""/>
    <constraint exp="" field="sunrise" desc=""/>
    <constraint exp="" field="sunset" desc=""/>
  </constraintExpressions>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column name="Cota" type="field" hidden="0" width="-1"/>
      <column type="actions" hidden="1" width="-1"/>
      <column name="SHAPE_AREA" type="field" hidden="0" width="-1"/>
      <column name="MDEcota6__" type="field" hidden="0" width="-1"/>
      <column name="Hora" type="field" hidden="0" width="-1"/>
      <column name="sunrise" type="field" hidden="0" width="-1"/>
      <column name="sunset" type="field" hidden="0" width="-1"/>
    </columns>
  </attributetableconfig>
  <editform>.</editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath>.</editforminitfilepath>
  <editforminitcode><![CDATA[# -*- codificación: utf-8 -*-
"""
Los formularios de QGIS pueden tener una función de Python que
es llamada cuando se abre el formulario.

Use esta función para añadir lógica extra a sus formularios.

Introduzca el nombre de la función en el campo
"Python Init function".
Sigue un ejemplo:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="Cota" editable="1"/>
    <field name="Hora" editable="1"/>
    <field name="MDEcota6__" editable="1"/>
    <field name="SHAPE_AREA" editable="1"/>
    <field name="sunrise" editable="1"/>
    <field name="sunset" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="Cota" labelOnTop="0"/>
    <field name="Hora" labelOnTop="0"/>
    <field name="MDEcota6__" labelOnTop="0"/>
    <field name="SHAPE_AREA" labelOnTop="0"/>
    <field name="sunrise" labelOnTop="0"/>
    <field name="sunset" labelOnTop="0"/>
  </labelOnTop>
  <widgets/>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <expressionfields/>
  <previewExpression>SHAPE_AREA</previewExpression>
  <mapTip>id</mapTip>
  <layerGeometryType>2</layerGeometryType>
</qgis>
