#!/bin/bash

for f in *sort.bam; do
 echo $f
# qsub -v input_file="$f" script.6a.samsort.pbs;
qsub -v input_file="$f" script.6b.g37.htseq.count.pbs
qsub -v input_file="$f" script.6c.g38.htseq.count.pbs
done;

# export QOUNTS=$(qsub -v input_file="$f" script.6b.htseq.count.pbs);
# export MERGE=$(qsub script.6c.merge.count.pbs);


