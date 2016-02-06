#!/bin/bash

gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black

base="stv_water_contents"

psbasemap -JX15/10 -R0/15/0/3 -Ba5f1:"Al@-2@-O@-3@- (wt %)":/a1f0.5:"H@-2@-O (wt %)":SWen -K -P > ${base}.ps

# convert mol percent AlOOH to wt % Al2O3 and H2O

echo 0 0.20 0.001 10 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 5 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 2.5 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 1 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,black >> ${base}.ps

awk '$11<1 {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -St0.2c -Gred >> ${base}.ps
awk '$11<1 {print $9, $13, $9-$10, $9, $9, $9+$10, $13-$14, $13, $13, $13+$14}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Si0.2c -Gblue >> ${base}.ps
awk 'substr($1, 0, 5)=="S6239" {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Sc0.15c -Gblack >> ${base}.ps
awk 'substr($1, 0, 5)=="H4095" {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Sc0.15c -Gred >> ${base}.ps

echo 0.6 2.8 | psxy -J -R -O -K -N -St0.2c -Gred >> ${base}.ps
echo 0.6 2.6 | psxy -J -R -O -K -N -Si0.2c -Gblue >> ${base}.ps
echo 0.6 2.2 | psxy -J -R -O -K -N -Sc0.15c -Gblack >> ${base}.ps
echo 0.6 2.4 | psxy -J -R -O -K -N -Sc0.15c -Gred >> ${base}.ps

echo "1.1 2.8 Paterson (1982) calibration" | pstext -J -R -O -K -F+jLM >> ${base}.ps
echo "1.1 2.6 Pawley et al. (1993) calibration" | pstext -J -R -O -K -F+jLM >> ${base}.ps
echo "1.1 2.2 S6239" | pstext -J -R -O -K -F+jLM >> ${base}.ps
echo "1.1 2.4 H4095" | pstext -J -R -O -K -F+jLM >> ${base}.ps


echo 14 0.33 10:1 | pstext -J -R -O -K -F+a5+f10,4,grey >> ${base}.ps
echo 14 0.59 5:1 | pstext -J -R -O -K -F+a10+f10,4,grey >> ${base}.ps
echo 14 1.09 2.5:1 | pstext -J -R -O -K -F+a15+f10,4,grey >> ${base}.ps
echo 14 2.60 1:1 | pstext -J -R -O -F+a33+f10,4,black >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi

rm ${base}.ps ${base}.epsi
evince ${base}.pdf
