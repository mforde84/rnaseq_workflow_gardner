###############
##### FUNCTIONS
###############

# if challenge != NULL, then change default var
challenge_default() {
 export `echo $1`=$2;
 read -p "Use default path ($1=$2): " challenge_response;
 if [[ $challenge_response != "" ]]; then
   export `echo $1`=`echo $challenge_response`;
 fi;
}

# if exist / generate reference directories
generate_ref_dir() {
 export ALIGNER=$1;
 export REFERENCE=$2;
 export REFERENCE_FASTA=`echo RNASEQ_"$REFERENCE"_FASTA | tr a-z A-Z`;
 export REFERENCE_GTF=`echo RNASEQ_"$REFERENCE"_GTF | tr a-z A-Z`;
 export REFERENCE_TRANSCRIPT=`echo RNASEQ_"$REFERENCE"_TRANSCRIPT | tr a-z A-Z`;
 export LENGTH="$RNASEQ_KMER_LENGTH";
 if [[ "$ALIGNER" == "star" ]]; then
  export LENGTH="$RNASEQ_READ_LENGTH";
  if [ ! -d "$RNASEQ_ROOT"/references/"$REFERENCE"."$ALIGNER"."$LENGTH" ]; then
   mkdir -p $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/2pass;
   ln -s `echo ${!REFERENCE_FASTA}` $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/2pass/genome.fa;
   ln -s `echo ${!REFERENCE_GTF}` $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/2pass/genes.gtf;
  fi;
 fi
 mkdir -p $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH";
 ln -s `echo ${!REFERENCE_FASTA}` $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/genome.fa;
 ln -s `echo ${!REFERENCE_GTF}` $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/genes.gtf;
 ln -s `echo ${!REFERENCE_TRANSCRIPT}` $RNASEQ_ROOT/references/"$REFERENCE"."$ALIGNER"."$LENGTH"/transcriptome.fa;
}

# general installation scheme for software build
make_install() {
 cd $RNASEQ_ROOT/dist/$1;
 CFLAGS="-fPIC" CXXFLAG="-fPIC" ./configure --prefix=$RNASEQ_ROOT/build --enable-shared;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;
}

# general installation scheme for python build
make_install_python() {
 cd $RNASEQ_ROOT/dist/$1;
 python setup.py install;
}
