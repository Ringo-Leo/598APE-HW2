#!/usr/bin/env bash

make

diabetes_values=()
cancer_values=()
housing_values=()
silk_wave_values=()
square_wave_values=()

NROUNDS="${NROUNDS:-3}"

tmp=$(mktemp)

echo "Start running, will run for ${NROUNDS} rounds"

for ((i=0; i<NROUNDS; i++))
do

echo "Round $i"

echo "Running on Diabetes:"
./genetic_benchmark diabetes >& $tmp
time=$(cat $tmp | sed -nE 's/.*Time\(Symbolic (Image Reconstruction|Classification|Regression) \(End-to-End\)\) = ([0-9.]+) sec.*/\2/p')
echo $time
diabetes_values+=($time)

echo "Running on Cancer:"
./genetic_benchmark cancer >& $tmp
time=$(cat $tmp | sed -nE 's/.*Time\(Symbolic (Image Reconstruction|Classification|Regression) \(End-to-End\)\) = ([0-9.]+) sec.*/\2/p')
echo $time
cancer_values+=($time)

echo "Running on Housing:"
./genetic_benchmark housing >& $tmp
time=$(cat $tmp | sed -nE 's/.*Time\(Symbolic (Image Reconstruction|Classification|Regression) \(End-to-End\)\) = ([0-9.]+) sec.*/\2/p')
echo $time
housing_values+=($time)

echo "Running on Silk waves:"
./genetic_benchmark silk-wave >& $tmp
time=$(cat $tmp | sed -nE 's/.*Time\(Symbolic (Image Reconstruction|Classification|Regression) \(End-to-End\)\) = ([0-9.]+) sec.*/\2/p')
echo $time
silk_wave_values+=($time)

echo "Running on Square waves:"
./genetic_benchmark square-wave >& $tmp
time=$(cat $tmp | sed -nE 's/.*Time\(Symbolic (Image Reconstruction|Classification|Regression) \(End-to-End\)\) = ([0-9.]+) sec.*/\2/p')
echo $time
square_wave_values+=($time)

done

average=$(printf "%s\n" "${diabetes_values[@]}" | awk '{sum+=$1} END {print sum/NR}')
echo "Diabetes Runtime: $average"
average=$(printf "%s\n" "${cancer_values[@]}" | awk '{sum+=$1} END {print sum/NR}')
echo "Cancer Runtime: $average"
average=$(printf "%s\n" "${housing_values[@]}" | awk '{sum+=$1} END {print sum/NR}')
echo "Housing Runtime: $average"
average=$(printf "%s\n" "${silk_wave_values[@]}" | awk '{sum+=$1} END {print sum/NR}')
echo "SilkWave Runtime: $average"
average=$(printf "%s\n" "${square_wave_values[@]}" | awk '{sum+=$1} END {print sum/NR}')
echo "SquareWave Runtime: $average"
