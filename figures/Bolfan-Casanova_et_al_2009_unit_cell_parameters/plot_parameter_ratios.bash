#!/bin/bash

base="post_stv_parameter_ratios"

psbasemap -JX10 -R0/100/0.63/0.67 -K -Ba20f5:"Pressure (GPa)":/a0.01f0.005:"Parameter ratio":SWen -P > ${base}.ps
for file in `ls *dat`
do
    psxy ${file} -J -R -O -K -Sc0.1c -N >> ${base}.ps
done

for file in post-stv_ca_ratios_*.dat
do
    awk 'NR==1 {print "S 0.1i", substr($2,3,1), substr($2, 4, 4), substr($3,3,10) , "0.25p 0.3i", f}' f=${file} ${file} | sed 's/post-stv_ca_ratios_//g' | sed 's/.dat//g' >> legend.tmp
done

pslegend legend.tmp -J -R -O -Dx0.0c/0.0c/10c/10c/BL >> ${base}.ps
rm legend.tmp


ps2epsi ${base}.ps
epstopdf ${base}.epsi
rm ${base}.ps ${base}.epsi
evince ${base}.pdf
