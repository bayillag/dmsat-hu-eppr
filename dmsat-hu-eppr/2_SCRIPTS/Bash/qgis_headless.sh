#!/bin/bash
# Run QGIS processing without GUI

set -e

conda activate dmsat

INPUT_FILE=$1
OUTPUT_FILE=$2

python3 << EOF
from qgis.core import *
from qgis.analysis import QgsNativeAlgorithms

# Initialize QGIS
QgsApplication.setPrefixPath('$CONDA_PREFIX', True)
qgs = QgsApplication([], False)
qgs.initQgis()

# Import and configure processing
import processing
from processing.core.Processing import Processing
Processing.initialize()

# Run algorithm
processing.run("qgis:heatmapkerneldensityestimation", {
    'INPUT': '$INPUT_FILE',
    'RADIUS': 5000,
    'PIXEL_SIZE': 100,
    'OUTPUT': '$OUTPUT_FILE'
})

qgs.exitQgis()
EOF

echo "QGIS processing complete: $OUTPUT_FILE"
