#!/bin/bash
 
#iterate through file with list of SRR accessions and download
while read -r line; do
 export INPUT_FILE=$line;
 export ID_download=`qsub -o $RNASEQ_SCRATCH/logs/$RNASEQ_JOB_IDENT -N log.sra.download.$INPUT_FILE -V $RNASEQ_ROOT/scripts/script.2a.sra.download.pbs`;
done < "$RNASEQ_SRA_LIST"

exit 0
