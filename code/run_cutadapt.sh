#!/bin/bash
dir=data

name=N14
for i in `seq 2 20`; do
    r1=${dir}\/raw_data\/Series\/${name}\/${i}\/${i}_L1_1.fq.gz
    r2=${r1/_1./_2.}
    echo $r1
    echo $r2
    cutadapt -a AAAAAAAAAA -A AGATCGGAAG -G TTTTTTTTTT --poly-a -j 4 --interleaved ${r1} ${r2} | \
    cutadapt -u 3 -U -3 -q 0,30 -Q 30,0 -m 15 -M 45 --interleaved \
    -o ${dir}\/trimmed\/Series\/${name}\/trimmed_${i}_1.fq -p ${dir}\/trimmed\/Series\/${name}\/trimmed_${i}_2.fq -
done