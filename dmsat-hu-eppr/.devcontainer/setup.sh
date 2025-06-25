
#!/bin/bash
set -e

# Create Conda environment
conda env create -f 0_SETUP/environment.yml

# Initialize QGIS for Ethiopia
mkdir -p /home/codespace/.local/share/QGIS/QGIS3/
echo "[SpatialRefSys]" >> /home/codespace/.local/share/QGIS/QGIS3/QGIS3.ini
echo "defaultProjectCrs=EPSG:20138" >> /home/codespace/.local/share/QGIS/QGIS3/QGIS3.ini

# Install R kernel
conda run -n dmsat Rscript -e "IRkernel::installspec(name = 'dmsat-r', displayname = 'R for DMSAT')"

# Download Ethiopia data
wget -nc https://data.humdata.org/dataset/.../eth_admin.zip -P 1_TRAINING/Day3-QGIS/shapefiles/
unzip -u 1_TRAINING/Day3-QGIS/shapefiles/eth_admin.zip -d 1_TRAINING/Day3-QGIS/shapefiles/

# Setup Git LFS
git lfs install
git lfs track "*.qgz" "*.zip" "*.gpkg"

# Create default QGIS project
cat << EOF > 1_TRAINING/Day3-QGIS/3-Basic_Mapping.qgz
<qgis>
  <projectCrs>EPSG:20138</projectCrs>
  <layer-tree-group name="Ethiopia">
    <layer-tree-layer source="shapefiles/eth_admin.gpkg" name="Admin Boundaries"/>
  </layer-tree-group>
</qgis>
EOF

echo "✅ DMSAT Environment Ready!"
echo "   Jupyter Lab: conda activate dmsat && jupyter lab --ip=0.0.0.0 --port=8888"
echo "   RStudio: conda activate dmsat && rstudio"