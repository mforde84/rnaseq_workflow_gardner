#!/bin/bash

for f in $(find . -name "*_1.fastq"); do
 export file2=$(echo $f | sed 's/_1/_2/g');
 qsub -v input_file="$f",input_file2="$file2" script.3a.star37.pbs;
 qsub -v input_file="$f",input_file2="$file2" script.3b.star38.pbs;
done

exit 0

