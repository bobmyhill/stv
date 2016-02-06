#!/bin/bash
gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black

base="ambient_stv_cell_parameters"

vrgn=0/0.2/45/50
prgn=0/0.2/2.5/4.5

psbasemap -JX15/10 -R${vrgn} -Ba0.2f0.1:"x Al":/a1f0.5:"Cell volume (\305@+3@+)":E  -K -P > ${base}.ps
awk 'NR>1 {print $1, ($2*$4*$6)}' volumes.dat | awk '$1<0.001 || $1 > 0.999' | psxy -J -R -O -K -W0.5,black,- >> ${base}.ps
echo 46.517 12.461 0.15 | awk '{printf "%f %f\n%f %f", 0, $1, $3, $1+$2*$3}' | psxy -J -R -O -K -W0.5,black,. >> ${base}.ps

psbasemap -J -R${prgn} -Ba0.05f0.01:"Al (a.p.f.u)":/a0.5f0.1:"Cell length (\305)":SWn -O -K -P >> ${base}.ps
# Correction lines for Bolfan-Casanova
awk 'NR==3 {printf "%f %f\n%f %f", 0.047, $2, $1, $2}' volumes.dat | psxy -J -R -O -K -W0.5,255/200/200 >> ${base}.ps
awk 'NR==3 {printf "%f %f\n%f %f", 0.047, $4, $1, $4}' volumes.dat | psxy -J -R -O -K -W0.5,255/200/200 >> ${base}.ps
awk 'NR==3 {printf "%f %f\n%f %f", 0.047, $6, $1, $6}' volumes.dat | psxy -J -R -O -K -W0.5,200/200/255 >> ${base}.ps

# Trend lines
awk 'NR>1 {print $1, $2}' a_b_parameters.dat | psxy -J -R -O -K -N -W0.5,red,- >> ${base}.ps
awk 'NR>1 {print $1, $4}' a_b_parameters.dat | psxy -J -R -O -K -N -W0.5,red,- >> ${base}.ps
awk 'NR>1 {print $1, $6}' a_b_parameters.dat | psxy -J -R -O -K -N -W0.5,blue,- >> ${base}.ps


# All data points (cell parameters)
awk '{print $1, $2, $2-$3, $2, $2, $2+$3}' volumes.dat | psxy -J -R -O -K -N -Gwhite -W0.5,red -EY0 >> ${base}.ps
awk '{print $1, $4, $4-$5, $4, $4, $4+$5, $2}' volumes.dat | psxy -J -R -O -K -N -Gwhite -W0.5,red -EY0 >> ${base}.ps
awk '{print $1, $6, $6-$7, $6, $6, $6+$7, $2}' volumes.dat | psxy -J -R -O -K -N -Gwhite -W0.5,blue -EY0 >> ${base}.ps

# Litasov data points
awk 'NR>1 {print $1, $2, $2-$3, $2, $2, $2+$3}' volumes_2.dat | psxy -J -R${vrgn} -O -K -N -EY0 -Sc0.1c -Gwhite -W0.5,black >> ${base}.ps

# Volumes of phases with cell parameters
awk '{if ($1<0.0001 || $1>0.9999) {print $1, ($2*$4*$6), $2}}' volumes.dat | grep -v ">>" | grep -v "%" | psxy -J -R -O -K -N -W0.5,black  >> ${base}.ps

awk 'NR==3 {printf "%f %f\n%f %f", 0.047, ($2*$4*$6), $1, ($2*$4*$6)}' volumes.dat | psxy -J -R -O -K -W0.5,200/200/200 >> ${base}.ps
awk '{print $1, ($2*$4*$6), $2}' volumes.dat | psxy -J -R -O -K -N -Sc0.1c -Gwhite -W0.5,black  >> ${base}.ps


# Panero and Stixrude data point
echo "0.0416 46.804 0.11 Panero and Stixrude, 2004" | awk '{print $1, $2, $2-$3, $2, $2, $2+$3}' | psxy -J -R -O -K -N -EY0 -St0.15c -Gwhite -W0.5,black >> ${base}.ps


# Legend
echo "0.12 47.0" | psxy -J -R -O -K -Sa0.3c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 46.8" | psxy -J -R -O -K -Sc0.1c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 46.6" | psxy -J -R -O -K -Ss0.2c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 46.4" | psxy -J -R -O -K -Sd0.15c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 46.2" | psxy -J -R -O -K -St0.15c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 46.0" | psxy -J -R -O -K -Sh0.15c -Gwhite -W0.5,black  >> ${base}.ps
echo "0.12 45.8" | psxy -J -R -O -K -Sc0.1c -Gblack -W0.5,black  >> ${base}.ps

echo "0.125 47.0 This study" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 46.8 Andrault et al. (2003)" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 46.6 Bolfan-Casanova et al. (2009)" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 46.4 Ono et al. (2002)" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 46.2 Panero and Stixrude (2004)" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 46.0 Smyth et al. (1995)" | pstext -F+jLM -J -R -O -K >> ${base}.ps
echo "0.125 45.8 Litasov et al. (2007)" | pstext -F+jLM -J -R -O -K >> ${base}.ps

echo "0.19 49.7 b" | pstext -F+jLM+f14,4,red -J -R -O -K >> ${base}.ps
echo "0.19 49.05 a" | pstext -F+jLM+f14,4,red -J -R -O -K >> ${base}.ps
echo "0.19 45.65 c" | pstext -F+jLM+f14,4,blue -J -R -O -K >> ${base}.ps
echo "0.19 48.2 V" | pstext -F+jLM+f14,4,black -J -R -O >> ${base}.ps

ps2epsi ${base}.ps
epstopdf ${base}.epsi
rm ${base}.*ps*

evince ${base}.pdf
