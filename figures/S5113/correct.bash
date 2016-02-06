#!/bin/bash

out=raman_compare
# Very simple ad-hoc background removal for Raman

#cat D_phase_16122011_01a.txt  | awk '{print $1, $2-100000*(1/$1)-200}' | psxy -JX15/10 -R200/4000/0/300 -Sc0.01c -K -P > ${out}.ps

#cat D_phase_16122011_01a.txt D_phase_16122011_01b.txt  | awk '{print $1, $2}' | psxy -J -R -Sc0.01c -Gred -O -K >> ${out}.ps

sample1d background.dat -ND_phase_16122011_01a.txt > tmp
sample1d background.dat -ND_phase_16122011_01b.txt >> tmp

cat D_phase_16122011_01a.txt D_phase_16122011_01b.txt > tmp2


#sample1d background.dat -ND_phase_16122011_01a.txt | psxy -J -R -Sc0.01c -Gblue -O -K >> ${out}.ps
#sample1d background.dat -ND_phase_16122011_01b.txt | psxy -J -R -Sc0.01c -Gblue -O -K >> ${out}.ps
paste tmp tmp2  | awk '{print $1, ($4-$2)/300}' | psxy -JX15/8 -R200/4000/0/1 -Gblack -Sc0.025c -B500f100:"Wavenumber (cm@+-1@+)":/50f0.1:"Normalised Intensity":SWen -K -P > ${out}.ps

echo "275 0.95 b. S5113 (Al-phase D; Mg,Fe free)" | pstext -J -R -O -K -F+jlm >> ${out}.ps
# #2
sample1d background_s4430.dat -Ns4430-1500.txt > tmp
sample1d background_s4430.dat -Ns4430-3400.txt >> tmp
cat s4430* > tmp2

paste tmp tmp2  | awk '{print $1, ($4-$2)/3000}' | psxy -Y10 -JX15/8 -R200/4000/0/1 -Gblack -Sc0.025c -B500f100:"Wavenumber (cm@+-1@+)":/50f0.1:"Normalised Intensity":SWen -O -K >> ${out}.ps

echo "275 0.95 a. S4430 (superaluminous phase D)" | pstext -J -R -O -F+jlm >> ${out}.ps

ps2epsi ${out}.ps
epstopdf ${out}.epsi

rm *epsi
rm *tmp*

evince ${out}.pdf &