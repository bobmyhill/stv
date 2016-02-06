#!/bin/bash


gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black


base="stv_xrd_comparison" 

psbasemap -JX15/10 -R30/90/0/110 -K -Ba15f5:"2 Theta":/a20f10:"Amplitude (arb. units.)":SWen -P > ${base}.ps

awk 'NR>1 {print $1, $2}' stishovite_pure.xy | psxy -J -R -O -K -W0.8,black,- >> ${base}.ps
awk 'NR>1 {print $1, $2*150 - 0.2 -  $1*0.036}' H4095new_001_exported.xy | psxy -J -R -O -K -W1,red >> ${base}.ps



echo "35.256 100 (110)"  | pstext -J -R -O -K -F+f10,4,black+jBC  >> ${base}.ps
echo "46.922 026 (101)"  | pstext -J -R -O -K -F+f10,4,red+jBC  >> ${base}.ps
echo "53.752 043 (111)"  | pstext -J -R -O -K -F+f10,4,black+jBC  >> ${base}.ps
echo "57.218 026 (210)"  | pstext -J -R -O -K -F+f10,4,red+jBC  >> ${base}.ps
echo "71.570 058 (211)"  | pstext -J -R -O -K -F+f10,4,red+jBC  >> ${base}.ps
echo "74.555 023 (220)"  | pstext -J -R -O -K -F+f10,4,black+jBC  >> ${base}.ps
echo "84.330 012 (220)"  | pstext -J -R -O -K -F+f10,4,black+jBC  >> ${base}.ps
echo "85.244 007 (002)"  | pstext -J -R -O -K -F+f10,4,black+jBC  >> ${base}.ps
echo "87.649 002 (310)"  | pstext -J -R -O -K -F+f10,4,red+jBC  >> ${base}.ps

echo 86 100 Pure anhydrous stishovite | pstext -J -R -O -K -F+f12,4,black+jBR  >> ${base}.ps
echo 86  95 Hydrous aluminous post stishovite | pstext -J -R -O -F+f12,4,red+jBR >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi

rm ${base}.ps ${base}.epsi

evince ${base}.pdf
