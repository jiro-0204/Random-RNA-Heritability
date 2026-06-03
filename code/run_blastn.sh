#!/bin/bash

result=data\/tsv\/N14_top_seqs_result.tsv
fasta=data\/fasta\/N14_top_seqs.fasta
SECONDS=0
echo Blasting sample...
blastn -query $fasta -task blastn -db \/home\/jiro\/blastdb\/core_nt -num_threads 16 -max_target_seqs 50 -outfmt 6 -strand plus -out $result
time=$SECONDS
echo Elapsed time $time seconds