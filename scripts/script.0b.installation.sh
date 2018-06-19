#!/bin/bash

#### if build directory exists, then it's assumed that installation was successful

if [ ! -d $RNASEQ_ROOT/build ]; then
 
 #### move to dist directory, generate build locations
 mkdir -p $RNASEQ_ROOT/build;
 cd $RNASEQ_ROOT/dist;

 #### untar distributables
 for f in *xz; do tar xf $f; done;
 for f in *gz; do tar zxf $f; done;

 #### jre8 install
 mv $RNASEQ_ROOT/dist/java-se-8u40-ri/* $RNASEQ_ROOT/build
 export JAVA_HOME=$RNASEQ_ROOT/build;

 #### gcc/6.4.0 install
 # compiles with system default gcc
 cd $RNASEQ_ROOT/dist/gcc-6.4.0;
 ./configure --prefix=$RNASEQ_ROOT/build;
 /usr/bin/expect <<EOD
 spawn make
  expect {
  -re "Archive name" { exp_send ".\r" exp_continue  }
  -re . { exp_continue  }
  timeout { exp_continue }
  eof { return 0 }
  }
EOD
 make install;
 
 #### source environment variables
 source $RNASEQ_ROOT/scripts/script.0.environment.variables.sh;

 #### install distributables
 make_install zlib-1.2.11;
 make_install bzip2-1.0.6;
 make_install xz-5.2.4;
 #### install pcre
    cd $RNASEQ_ROOT/dist/pcre-8.39;
    ./configure --enable-utf8 --prefix=$RNASEQ_ROOT/build --disable-cpp
    make;
    make install PREFIX=$RNASEQ_ROOT/build;
    cd $RNASEQ_ROOT/dist;
 make_install curl-7.60.0;
 make_install Python-2.7.15;
 make_install_pip cython-0.28.3;
 make_install_pip swig-re-3.0.12
 make_install_pip matplotlib-2.2.2;
 make_install_pip numpy-1.14.5;
 make_install_pip pysam-0.14.1;
 make_install_pip htseq-release_0.9.1;
 make_install R-3.5.0;
 make_install cufflinks_v2.2.1;
 make_install samtools-0.1.19;
 #### make file is screwed up for STAR have to manually move to bin
    make_install STAR-2.5.3a/source; 
    mv $RNASEQ_ROOT/dist/STAR-2.5.3a/bin/STAR $RNASEQ_ROOT/build/bin;
 #### install salmon
 mkdir -p $RNASEQ_ROOT/dist/salmon/build;
 cd $RNASEQ_ROOT/dist/salmon/build;
 cmake -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;
 cd $RNASEQ_ROOT/dist;

 #### clean up packages distributables
 cd $RNASEQ_ROOT;
 rm -rf $RNASEQ_ROOT/dist;

else

 source $RNASEQ_ROOT/scripts/script.0.environment.variables.sh;
 
fi
