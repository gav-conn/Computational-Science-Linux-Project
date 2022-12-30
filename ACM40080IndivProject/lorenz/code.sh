#!/bin/bash

rm ThreeLorenz.png
printf '0.001\n0.0005\n0.0001\n' > DELTAT.csv # set up DELTAT file

awk -F "," '{print $1}' DELTAT.csv  | while read line; do # Set up loop to go through different values of DELTAT
#echo $line

sed -e "s/DELTAT/$line/g" lorenz_x.py > lorenz_x_$line.py  # Replace DELTAT with relevant value
sed -i "$ a np.savetxt(\"t_${line}.txt\", t)" lorenz_x_$line.py # Append functions to save t & xf to end of file
sed -i "$ a np.savetxt(\"xf_${line}.txt\", xf)" lorenz_x_$line.py

done

# Create file composed of the names of the relevant .py files for each DELTAT value
ls | awk -v pat=lorenz_x_0.* '$0~pat {print $1}' > temp.txt

qsub job1.qsub
qsub -hold_jid pycode job2.qsub

rm DELTAT.csv
