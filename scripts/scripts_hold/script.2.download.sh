#!/bin/bash
 
 #iterate through file with list of SRR accessions and download
 while read -r line; do
  downloadID=`qsub -N log.sra.download."$line" -v RNASEQ_ROOT="$RNASEQ_ROOT" -v input_line="$line" script.2a.sra.download.pbs`
  
 done < "$RNASEQ_SRA_LIST"

done
