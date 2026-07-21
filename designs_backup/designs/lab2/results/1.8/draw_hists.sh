#!/bin/bash

# Plik wejściowy
INPUT_FILE="M1_Iruns.dat"

# 1. Divide into 6 different subfiles
awk '
/^----- W\/L=/ {
    w = $3; l = $5; idac = $7;
    current_file = "data_W" w "_L" l "_" idac ".dat"
    next
}
/^RUN=/ {
    if (current_file != "") {
        print $0 > current_file
    }
}' "$INPUT_FILE"

# 2.generate the histograms
for datafile in data_W*.dat; do
    filename=$(basename "$datafile" .dat)
    w_val=$(echo "$filename" | cut -d'_' -f2 | sed 's/W//')
    l_val=$(echo "$filename" | cut -d'_' -f3 | sed 's/L//')
    idac_val=$(echo "$filename" | cut -d'_' -f4)
    
    output_png="histogram_W${w_val}_L${l_val}_${idac_val}.png"
    
    echo "Generowanie wykresu: $output_png..."
    
    # Choose binwidth scale
    if [[ "$idac_val" == *"100n"* ]]; then
        binwidth="0.0005"
    else
        binwidth="0.05"
    fi

    # use gnuplot
    gnuplot <<- EOF
		set terminal pngcairo size 800,600 enhanced font 'Verdana,10'
		set output '$output_png'
		set title "Histogram MC: W/L = $w_val / $l_val, IDAC = $idac_val"
		set xlabel "M1 Id (uA)"
		set ylabel "Count"
		set grid
		
		binwidth = $binwidth
		bin(x, s) = s*floor(x/s) + s/2.0
		
		plot "$datafile" using (bin(\$4 * 1e6, binwidth)):(1.0) smooth frequency with boxes title "Dane MC" lc rgb "blue"
	EOF
done

# Remove subfiles, leave only .png
rm -f data_W*.dat

echo "Done!"
