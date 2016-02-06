#!/bin/bash
gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black

base="raman"


psbasemap -JX15/7 -R200/3600/-0.05/1.8 -Ba200f100:"Raman shift (cm@+-1@+)":/a5f1:"":S  -K -P > ${base}.ps
#sample1d AlOOH_Raman_Xue_et_al_2006_high.dat -Fa -I1 | psxy -J -R -O -K -W0.5,black >> ${base}.ps
#sample1d AlOOH_Raman_Xue_et_al_2006_low.dat -Fa -I1  | psxy -J -R -O -K -W0.5,black >> ${base}.ps

# Stishovite
awk 'substr($0,1,1)!="#" {print $1, $2/1000}' raman_stishovite_R080042_rruff_database.txt | sed 's/,//g' | psxy -J -R -O -K -W1,red >> ${base}.ps


# Phase D
sample1d S5113/background.dat -NS5113/D_phase_16122011_01a.txt > tmp
paste tmp S5113/D_phase_16122011_01a.txt | awk '{print $1, 1.05+($4-$2)/300}' | psxy -J -R -O -K -W0.5,100/100/100 >> ${base}.ps

sample1d S5113/background.dat -NS5113/D_phase_16122011_01b.txt > tmp
paste tmp S5113/D_phase_16122011_01b.txt | awk '{print $1, 1.05+($4-$2)/300}' | psxy -J -R -O -K -W0.5,100/100/100 >> ${base}.ps


# delta-AlOOH
awk '{print $1, 0.65 + $2}' AlOOH_Raman_Xue_et_al_2006_low.dat | psxy -J -R -O -K -W1,blue >> ${base}.ps
awk '$1>1890 {print $1, 0.65 + $2}' AlOOH_Raman_Xue_et_al_2006_high.dat | psxy -J -R -O -K -W1,blue >> ${base}.ps


# Hydrous Stishovite
sample1d green_raman_200W/green_raman_background.dat -Ngreen_raman_200W/H4095a_60x60_150-3700cm-1.txt > background.tmp
max=300
paste green_raman_200W/H4095a_60x60_150-3700cm-1.txt background.tmp | awk '($2-$4) > -5 {print $1, 0.30 + ($2-$4)/m}' m=${max} | psxy -J -R -O -K -W1,black >> ${base}.ps
rm background.tmp

echo "1360 0.06 stishovite (R080042)" | pstext -F+jLM+f10,4,red -J -R -O -K >> ${base}.ps
echo "1500 0.23 hydrous stishovite (H4095a)" | pstext -F+jLM+f10,4,black -J -R -O -K >> ${base}.ps
echo "1560 0.70 @~\144@~-AlOOH" | pstext -F+jLM+f10,4,blue -J -R -O -K >> ${base}.ps
echo "1700 1.08 phase D (S5113)" | pstext -F+jLM+f10,4,100/100/100 -J -R -O >> ${base}.ps


ps2epsi ${base}.ps
epstopdf ${base}.epsi
rm ${base}.*ps*

evince ${base}.pdf
