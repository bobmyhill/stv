#!/bin/bash


gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black


###
base="green_raman_raw"

psbasemap -JX15/6 -R150/3250/00/2000 -Ba500f100:"Wavenumber (cm@+-1@+)":/a200f100:"Amplitude":SWen -K -P > ${base}.ps

# Remove background using pickfile
sample1d green_raman_background.dat -NH4095a_60x60_150-3700cm-1.txt > background.tmp

paste H4095a_60x60_150-3700cm-1.txt | awk '{print $1, $2}' | psxy -J -R -O -K -W1,black >> ${base}.ps
paste background.tmp | awk '{print $1, $2}' | psxy -J -R -O -W1,red >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi


convert -density 300x300 green_raman.pdf  green_raman.jpg

rm ${base}.ps ${base}.epsi


###
base="green_raman"

psbasemap -JX15/6 -R150/3250/-25/250 -Ba500f100:"Wavenumber (cm@+-1@+)":/a50f10:"Amplitude":SWen -K -P > ${base}.ps


awk 'substr($0,1,1)!="#" {print $1, $2}' raman_stishovite_R070183_rruff_database.txt | sed 's/,//g' | psxy -J -R -O -K -W0.5,red >> ${base}.ps

# Remove background using pickfile
sample1d green_raman_background.dat -NH4095a_60x60_150-3700cm-1.txt > background.tmp
paste H4095a_60x60_150-3700cm-1.txt background.tmp | awk '{print $1, $2-$4}' | psxy -J -R -O >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi


convert -density 300x300 green_raman.pdf  green_raman.jpg

rm ${base}.ps ${base}.epsi
evince ${base}.pdf
