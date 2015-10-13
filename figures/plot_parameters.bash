#!/bin/bash

base="ambient_stv_cell_parameters"

psbasemap -JX10 -R0/1/2.5/5 -Ba0.2f0.1:"x Al":/a0.5f0.1:"Cell length (\305)":SWn -K -P > ${base}.ps
awk 'NR>1 {print $1, $2, $2-$3, $2, $2, $2+$3}' volumes.dat | psxy -J -R -O -K -N -Sc0.1c -Gred -EY0 >> ${base}.ps
awk 'NR>1 {print $1, $4, $4-$5, $4, $4, $4+$5}' volumes.dat | psxy -J -R -O -K -N -Sc0.1c -Gred -EY0 >> ${base}.ps
awk 'NR>1 {print $1, $2}' volumes.dat | psxy -J -R -O -K -N -W1,red,. >> ${base}.ps
awk 'NR>1 {print $1, $4}' volumes.dat | psxy -J -R -O -K -N -W1,red,. >> ${base}.ps
awk 'NR>1 {print $1, $6, $6-$7, $6, $6, $6+$7}' volumes.dat | psxy -J -R -O -K -N -Sc0.1c -Gblue -EY0 >> ${base}.ps


psbasemap -JX10 -R0/1/40/70 -Ba0.2f0.1:"x Al":/a5f1:"Cell volume (\305@+3@+)":E -O -K >> ${base}.ps
awk 'NR>1 {print $1, ($2*$4*$6)}' volumes.dat | psxy -J -R -O -K -N -Sc0.1c -Gblack  >> ${base}.ps

awk 'NR>1 {print $1, $2, $2-$3, $2, $2, $2+$3}' volumes_2.dat | psxy -J -R -O -K -N -EY0 -Sc0.1c -Gblack  >> ${base}.ps
awk 'NR>1 {print $1, ($2*$4*$6)}' volumes.dat | awk '$1<0.001 || $1 > 0.999' | psxy -J -R -O -N -W1,black,- >> ${base}.ps


ps2epsi ${base}.ps
epstopdf ${base}.epsi
rm ${base}.*ps*

evince ${base}.pdf
