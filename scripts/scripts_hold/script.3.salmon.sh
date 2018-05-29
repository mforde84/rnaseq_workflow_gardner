#!/bin/bash

#generate transcriptome fasta, then index with salmon
#qsub script.2a.index.g37.salmon.pbs;
#qsub script.2b.index.g38.salmon.pbs;

#iterate through each pair of read files
for f in *_1.fastq; do

 #generate the paired read file name
 export file2=$(echo $f | sed 's/_1/_2/g');

 #perform quantification with salmon, but only if the previous indexing step has completed successfully
 #qsub -k depend:anyok $g37_quant -v input_file="$f",input_file2="$file2" script.2c.quasi.g37.salmon.pbs;
 #qsub -k depend:anyok $g38_quant -v input_file="$f",input_file2="$file2" script.2d.quasi.g38.salmon.pbs;
 
 qsub -v input_file="$f",input_file2="$file2" script.2c.quasi.g37.salmon.pbs;
 qsub -v input_file="$f",input_file2="$file2" script.2d.quasi.g38.salmon.pbs;

done

exit 0
