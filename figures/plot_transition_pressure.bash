#!/bin/bash

gmtset FONT_ANNOT_PRIMARY	   = 10p,4,black
gmtset FONT_LABEL        	   = 14p,4,black


base="transition_pressure"

psxy transition_pressure.dat -Ba2f1:"Al@-2@-O@-3@- (wt %)":/a20f5:"Pressure (GPa)":SWen -JX15/10 -R0/14/0/100 -Sc0.2c -Gred -N > ${base}.ps

