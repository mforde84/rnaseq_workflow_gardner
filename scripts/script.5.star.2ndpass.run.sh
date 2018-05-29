#!/bin/bash

for f in $(find . -name "*_1.fastq"); do
 export file2=$(echo $f | sed 's/_1/_2/g');
 qsub -v input_file="$f",input_file2="$file2" script.5a.star37.2pass.pbs;
 qsub -v input_file="$f",input_file2="$file2" script.5b.star38.2pass.pbs;
done

exit 0

