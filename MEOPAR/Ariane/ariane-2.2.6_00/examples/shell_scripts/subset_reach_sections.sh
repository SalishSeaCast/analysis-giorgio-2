#!/bin/bash
####################
## N.G. June 2007 ##
###################################################
## This script extracts only particules which    ##
## have reach a section and stores their indices ##
## in a subset file using by ariane for a futur  ##
## quantitative simulation                       ##
###############################################################
# We assume that nco commands are available on your computer ##
###############################################################

ncks -s '%i\n' -F -C -v final_section ariane_initial.nc > final_section.txt

size=`wc -l final_section.txt`
size=${size% *}
(( size = size - 8 ))
echo "$size particules are read..."

tail -n ${size} final_section.txt > dummy.txt
rm final_section.txt
mv dummy.txt final_section.txt

cat -n final_section.txt >  dummy.txt
rm final_section.txt
mv dummy.txt final_section.txt

sed -e /-1/d final_section.txt > subset.txt

size=`wc -l subset.txt`
size=${size% *}
echo "${size} particules for the subset..."
