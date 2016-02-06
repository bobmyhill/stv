#!/bin/bash

base='phase_diagram'
psbasemap -JX15/10 -R0/1/1000/2250 -K -B0.2f0.1:"Al/(Si+Al)":/250f50:"Temperature (@~\260@~C)":SWen -P > ${base}.ps

echo 0 0 | psxy -J -R0/1/1273/2523 -O -K >> ${base}.ps

awk '$2 == "Stv" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -St0.2c -Gblue -Wblack >> ${base}.ps

awk '$2 == "pStv" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -Sc0.2c -Gred -Wblack >> ${base}.ps

awk '$2 == "iStv" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -Si0.2c -Gblue -Wblack >> ${base}.ps

awk '$2 == "Egg" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -Sa0.2c -Gwhite -Wblack >> ${base}.ps

awk '$2 == "D" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -Sa0.2c -Gwhite -Wblack >> ${base}.ps

awk '$2 == "d-AlOOH" {print $5, $3, $6, $5, $5, $7, $3-$4, $3, $3, $3+0.2*$4}' phase_diagram.dat | psxy -J -R -O -K -EXY0 -Sa0.2c -Gwhite -Wblack >> ${base}.ps


psxy phase_boundaries.dat -J -R0/1/1300/2550 -O -K >> ${base}.ps
echo "0.98 2500 26 GPa" | pstext -F+jRT+f14,4,black -J -R -O -K >> ${base}.ps
echo "0.98 2420 + melt" | pstext -F+jRT+f12,4,black -J -R -O -K >> ${base}.ps
pstext phase_labels.dat -J -R -O >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi
okular ${base}.pdf

rm *.ps *.epsi
