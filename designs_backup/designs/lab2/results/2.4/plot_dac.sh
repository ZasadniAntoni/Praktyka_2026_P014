#!/bin/bash

DATA_FILE="/foss/designs/lab2/results/2.4/Idac_results_1.dat"
OUT_DIR="/foss/designs/lab2/results/2.4"
CLEAN_DATA="${OUT_DIR}/clean_data.tmp"

PLOT_LIN_NAME="plot_dac_lin.png"
PLOT_STEP_NAME="plot_dac_step.png"
PLOT_LIN_PATH="${OUT_DIR}/${PLOT_LIN_NAME}"
PLOT_STEP_PATH="${OUT_DIR}/${PLOT_STEP_NAME}"

mkdir -p "${OUT_DIR}"

rm -f "${PLOT_LIN_PATH}" "${PLOT_STEP_PATH}" "${CLEAN_DATA}"

if [ ! -f "$DATA_FILE" ]; then
    echo "Error: $DATA_FILE does not exist!"
    exit 1
fi

# 1. Extract purely numerical pairs: <dac_bit> <I_dac>
# Filters lines with 'dac_bit=' and extracts numbers after 'dac_bit=' and 'I_dac[uA]='
awk '/dac_bit=/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /dac_bit=/) { dac=$(i+1) }
        if ($i ~ /I_dac.*=/) { idac=$(i+1) }
    }
    print dac, idac
}' "$DATA_FILE" > "$CLEAN_DATA"

# Check if clean data was generated
if [ ! -s "$CLEAN_DATA" ]; then
    echo "Failed to parse data. Here is the first line of your dat file:"
    head -n 5 "$DATA_FILE"
    exit 1
fi

echo "Parsed data successfully. Generating plots..."

# 2. Plot 1: Continuous line (extrapolated)
gnuplot << EOF
set terminal pngcairo size 1920,1080 font "Sans,16"
set output "${PLOT_LIN_PATH}"

set title "I_{dac} vs. dac bit" font ",18"
set xlabel "dac bit"
set ylabel "I_{dac} [uA]"
set grid
set key off

set xrange [-0.5:31.5]
set xtics 1

plot "${CLEAN_DATA}" using 1:2 with linespoints lw 2 pt 7 ps 0.8 linecolor rgb "#0066cc"
EOF

# 3. Plot 2: Steps
gnuplot << EOF
set terminal pngcairo size 1920,1080 font "Sans,16"
set output "${PLOT_STEP_PATH}"

set title "I_{dac} vs. dac bit" font ",18"
set xlabel "dac bit"
set ylabel "I_{dac} [uA]"
set grid
set key off

set xrange [-0.5:31.5]
set xtics 1

plot "${CLEAN_DATA}" using 1:2 with steps lw 2 linecolor rgb "#cc0000"
EOF

# Clean up temporary file
rm -f "$CLEAN_DATA"

echo "Success! Plots created in ${OUT_DIR}:"
echo " - ${PLOT_LIN_NAME}"
echo " - ${PLOT_STEP_NAME}"