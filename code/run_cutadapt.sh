#!/bin/bash
dir=data

name=N14
Rounds=(1 2 3 5 6 8 10 11 13 15 17 19 20 22 24 26 28 29 30)

if [ ! -d ${dir}\/trimmed]; then
    mkdir -p ${dir}\/trimmed
fi

if [ ! -d ${dir}\/trimmed\/${name} ]; then
    mkdir -p ${dir}\/trimmed\/${name}
fi

for i in "${Rounds[@]}"; do
    r1=${dir}\/raw_data\/${name}\/${name}_R${i}_1.fq.gz
    r2=${r1/_1./_2.}
    echo $r1
    echo $r2
    cutadapt -a AAAAAAAAAA -A AGATCGGAAG -G TTTTTTTTTT --poly-a -j 4 --interleaved ${r1} ${r2} | \
    cutadapt -u 3 -U -3 -q 0,30 -Q 30,0 -m 15 -M 45 --interleaved \
    -o ${dir}\/trimmed\/${name}\/trimmed_${i}_1.fq -p ${dir}\/trimmed\/${name}\/trimmed_${i}_2.fq -
done