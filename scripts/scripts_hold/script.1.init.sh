#!/bin/bash

##################
# perform indexing
##################

# G37 star1
if [ ! -f $RNASEQ_ROOT/references/g37.star.$RNASEQ_READ_LENGTH/SA ]; then 
 ID.g37.index.star1=`GENOME_DIR=$RNASEQ_ROOT/references/g37.$RNASEQ_READ_LENGTH qsub -N log.indexing.g37.STAR1pass -V $RNASEQ_ROOT/scripts/script.1a.star.index.pbs | sed 's/\..*//g'`;
fi

# G37 salmon
if [ ! -d $RNASEQ_ROOT/references/g37.salmon.$RNASEQ_KMER_LENGTH/transcript_index ]; then 
 ID.g37.index.salmon=`GENOME_DIR=$RNASEQ_ROOT/references/g37.$RNASEQ_READ_LENGTH qsub -N log.indexing.g37.salmon -V $RNASEQ_ROOT/scripts/script.1b.salmon.index.pbs | sed 's/\..*//g'`; 
fi

# G38 star1
if [ ! -f $RNASEQ_ROOT/references/g38.star.$RNASEQ_READ_LENGTH/SA ]; then
 ID.g38.index.star1=`GENOME_DIR=$RNASEQ_ROOT/references/g38 qsub -N log.indexing.g38.STAR1pass -V $RNASEQ_ROOT/scripts/script.1a.star.index.pbs | sed 's/\..*//g'`;
fi;

# G38 salmon
if [ ! -d $RNASEQ_ROOT/references/g38.salmon.$RNASEQ_KMER_LENGTH/transcript_index ]; then
 ID.g38.index.salmon=`GENOME_DIR=$RNASEQ_ROOT/references/g38 qsub -N log.indexing.g38.salmon -V $RNASEQ_ROOT/scripts/script.1b.salmon.index.pbs | sed 's/\..*//g'`;
fi;

################## - working / finished



# workflow
while read -r input_line; do
 
 ###finished
 export ID.download=`qsub -N log.sra.download -V script.2a.sra.download.pbs;`;

done < "$RNASEQ_SRA_LIST";



  export GENOME_DIR=$RNASEQ_ROOT/references/g37;

  for input_file in $RNASEQ_ROOT/data/reads/*_1.fastq; do
   export input_file2=`echo $input_file | sed 's/_1.fastq/_2.fastq/g'`;
   export ID.align.star1=$ID.align.star1,`qsub -N log.star.align.1pass -W depend=afterok:$ID.g37.index.star1,$ID.download -V script.3a.star.align.pbs | sed 's/\..*//g';`;
   export ID.quasi.salmon=$ID.quasi.salmon,`qsub -N log.salmon.quasi -W depend=afterok:$ID.g37.index.salmon,$ID.download -V script.3b.quasi.salmon.pbs | sed 's/\..*//g';`;
  done;
  
  ID.g37.index.star1=`qsub -N log.indexing.g37.STAR1pass -V $RNASEQ_ROOT/scripts/script.1a.star.index.pbs | sed 's/\..*//g'`;

 fi;

 if [[ "$RNASEQ_GENOMES" == "both" ]] || [[ "$RNASEQ_GENOMES" == "g38" ]]; then

 fi;

done < "$RNASEQ_SRA_LIST";
fi



exit 0
