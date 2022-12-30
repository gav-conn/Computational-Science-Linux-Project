#!/bin/bash

rm -f results.txt # Clear the output .txt file

awk -F "," '{print $2}' stations.csv  | while read line; do # Loop through each station in stations.csv file

#echo $line
curl -O https://cli.fusio.net/cli/climate_data/webdata/hly$line.zip # Download the corresponding station data
unzip -o hly$line.zip # unzip the file

begin=$(awk -F"," '/01-jan-2019 00:00/ {print NR}' hly$line.csv) # Find/store where first 2019 reading occurs
final=$(awk -F"," '/31-dec-2019 23:00/ {print NR}' hly$line.csv) # Find/store where final 2019 reading occurs
#echo $begin; echo $final;
sed -n "${begin},${final}p" hly$line.csv > hly1$line.csv # Extract only the data corresponding to 2019
awk -F',' '$2==0' hly1$line.csv > hly2$line.csv # Remove missing datapoints

statname=$(awk -F"," -v pat=","$line '$0~pat {print $1}' stations.csv)
avtemp=$(awk -F"," '{ avtemp += $5 } END { print avtemp/NR }' hly2$line.csv) # Calculate the average temperature
#echo $statname; echo $avtemp;

max=$(awk -F"," 'NR==1{max = $5; date = $1; next} {if ($5 > max) {max = $5; date = $1}} END {print max " degrees C on " date}' hly2$line.csv) 
# Calculate/store the maximum value and date on which it occurred
min=$(awk -F"," 'NR==1{min = $5; mindate = $1; next} {if ($5 < min) {min = $5; mindate = $1}} END {print min " degrees C on " mindate}' hly2$line.csv) # Calculate/store the maximum value and date on which it occurred
#echo $max; echo $min

# Create a text file containing relevant values by appending them to an output .txt file
printf '\n The average temperature at %s was %s degrees C' "$statname" "$avtemp" >> results.txt
printf '\n The maximum temperature at %s was %s' "$statname" "$max" >> results.txt
printf '\n The minimum temperature at %s was %s \n' "$statname" "$min" >> results.txt

done

rm Data_* KeyHourly.txt hly* # Remove surplus files from directory

cat results.txt # Output results.txt to console
