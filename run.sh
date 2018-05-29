###############
##### FUNCTIONS
###############

# if challenge != NULL, then change default var
challenge_default() {
 export `echo $1`=$2;
 read -p "Use default location ($1=$2): " challenge_response;
 if [[ $challenge_response != "" ]]; then
   export `echo $1`=`echo $challenge_response`;
 fi
}


########################
##### set work directory
########################

# challenge default directory location
challenge_default RNASEQ_ROOT `pwd`;
if [ ! -d "$RNASEQ_ROOT" ]; then
 mkdir -p $RNASEQ_ROOT || echo "You don't have permission to create this work directory";
 if [[ `pwd` != "$RNASEQ_ROOT" ]]; then
  cd $RNASEQ_ROOT || exit 0;
  ###git clone <rep> . ########################## TODO #######################
 fi
fi


##########################
##### set genome locations
##########################

# challenge default locations and genome selections
export RNASEQ_GENOMES="both";
read -p "Which genome assembly would you like to use (default both, g37 or g38): " challenge_GENOMES;
if [ -z "$challenge_GENOMES" ]; then
 challenge_default RNASEQ_G37_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.dna.primary_assembly.fa";
 challenge_default RNASEQ_G37_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.87.gtf";
 challenge_default RNASEQ_G38_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.dna.primary_assembly.fa";
 challenge_default RNASEQ_G38_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.92.gtf"; 
else
 case "$challenge_GENOMES" in
  both)
   challenge_default RNASEQ_G37_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.dna.primary_assembly.fa";
   challenge_default RNASEQ_G37_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.87.gtf";
   challenge_default RNASEQ_G38_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.dna.primary_assembly.fa";
   challenge_default RNASEQ_G38_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.92.gtf"; 
   ;;
  g37)
   export RNASEQ_GENOMES="g37";
   challenge_default RNASEQ_G37_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.dna.primary_assembly.fa";
   challenge_default RNASEQ_G37_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g37/Homo_sapiens.GRCh37.87.gtf";
   ;;
  g38)
   export RNASEQ_GENOMES="g38";
   challenge_default RNASEQ_G38_FASTA "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.dna.primary_assembly.fa";
   challenge_default RNASEQ_G38_GTF "/group/referenceFiles/Homo_sapiens/Ensembl/martin_g37_g38/g38/Homo_sapiens.GRCh38.92.gtf";
   ;;
 esac;
fi;

#################################
##### set genome indexing options
#################################

# read length for star indexing
challenge_default RNASEQ_READ_LENGTH "99";

# kmer length for salmon indexing
challenge_default RNASEQ_KMER_LENGTH "31";


########################################
##### check if working directories exist
########################################

# logs folder
if [ ! -d "$RNASEQ_ROOT"/logs ]; then
echo logs
# mkdir $RNASEQ_ROOT/logs
fi

# references folder
if [ ! -d "$RNASEQ_ROOT"/references ]; then
echo references
# mkdir -p $RNASEQ_ROOT/references/g37/2pass
# mkdir -p $RNASEQ_ROOT/references/g38/2pass
# ln -s $RNASEQ_G37_FASTA $RNASEQ_ROOT/references/g37/genome.fa
# ln -s $RNASEQ_G37_GTF $RNASEQ_ROOT/references/g37/genes.gtf
# ln -s $RNASEQ_G37_FASTA $RNASEQ_ROOT/references/g37/2pass/genome.fa
# ln -s $RNASEQ_G37_GTF $RNASEQ_ROOT/references/g37/2pass/genes.gtf
# ln -s $RNASEQ_G38_FASTA $RNASEQ_ROOT/references/g38/genome.fa
# ln -s $RNASEQ_G38_GTF $RNASEQ_ROOT/references/g38/genes.gtf
# ln -s $RNASEQ_G38_FASTA $RNASEQ_ROOT/references/g38/2pass/genome.fa
# ln -s $RNASEQ_G38_GTF $RNASEQ_ROOT/references/g38/2pass/genes.gtf
fi

# data folder
if [ ! -d "$RNASEQ_ROOT"/data ]; then
echo data
# mkdir -p $RNASEQ_ROOT/data/counts/htseq/g37
# mkdir $RNASEQ_ROOT/data/counts/htseq/g38
# mkdir -p $RNASEQ_ROOT/data/counts/salmon/g37
# mkdir $RNASEQ_ROOT/data/counts/salmon/g38
# mkdir $RNASEQ_ROOT/data/intermediate
# mkdir $RNASEQ_ROOT/data/reads
fi

# results folder
if [ ! -d "$RNASEQ_ROOT"/results ]; then
echo results
# mkdir -p $RNASEQ_ROOT/results/bams;
# mkdir $RNASEQ_ROOT/results/counts;
# mkdir $RNASEQ_ROOT/results/cpm;
fi


####################
##### job identifier
####################

# challenge base filename job identifier
challenge_default RNASEQ_JOB_IDENT `date +%Y.%m.%d.%Hh.%Mm`;

# challenge location of sra asseccion list
challenge_default RNASEQ_SRA_LIST $RNASEQ_ROOT/scripts/sra_download_list


####################
##### start workflow
####################

#$RNASEQ_ROOT/scripts/script.0.run.sh

