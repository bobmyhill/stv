#!/bin/bash

gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black

base="stv_literature_compositions"

psbasemap -JX15/10 -R0/8/0/1.2 -Ba2f1:"Al@-2@-O@-3@- (wt %)":/a0.2f0.1:"H@-2@-O (wt %)":SWen -K -P > ${base}.ps

# convert mol percent AlOOH to wt % Al2O3 and H2O

echo 0 0.20 0.001 10 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 5 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 2.5 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,grey,- >> ${base}.ps
echo 0 0.20 0.001 1 | awk '{for (i=$1; i<$2; i=i+$3) {print 100*(i/2*101.96) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08), 100*(i/2*18.02/$4) / (i/2*101.96 + i/2*18.02/$4 + (1-i)*60.08)}}' | psxy -J -R -O -K -W1,black >> ${base}.ps

awk '$11<1 {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -St0.2c -Gred >> ${base}.ps
awk '$11<1 {print $9, $13, $9-$10, $9, $9, $9+$10, $13-$14, $13, $13, $13+$14}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Si0.2c -Gblue >> ${base}.ps
#awk 'substr($1, 0, 5)=="S6239" {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Sc0.15c -Gred >> ${base}.ps
#awk 'substr($1, 0, 5)=="H4095" {print $9, $11, $9-$10, $9, $9, $9+$10, $11-$12, $11, $11, $11+$12}' Al_H2O_contents.dat | psxy -J -R -O -K -N -EXY0 -Sc0.15c -Gblack >> ${base}.ps

echo 7 0.16 10:1 | pstext -J -R -O -K -F+a5+f10,4,grey >> ${base}.ps
echo 6.9 0.28 5:1 | pstext -J -R -O -K -F+a10+f10,4,grey >> ${base}.ps
echo 6.6 0.51 2.5:1 | pstext -J -R -O -K -F+a20+f10,4,grey >> ${base}.ps
echo 5 0.94 1:1 | pstext -J -R -O -F+a40+f10,4,black >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi

rm ${base}.ps ${base}.epsi
evince ${base}.pdf
