#!/bin/bash

#### source environment variables
#source $RNASEQ_ROOT/scripts/script.0c.environment.variable#s.sh;
#will likely need to source post gcc installation


#### if build directory exists, assume software install works

if [ ! -d $RNASEQ_ROOT/build ]; then

 #### generate build locations
 mkdir -p $RNASEQ_ROOT/build;

 #### untar distributables
 cd $RNASEQ_ROOT/dist;
 for f in *xz; do echo "Extracting $f"; tar xvf $f; done;
 for f in *bz2; do echo "Extracting $f"; tar xvf $f; done;
 for f in *gz; do echo "Extracting $f"; tar zxvf $f; done;
 cd $RNASEQ_ROOT;

 #### jre8 install
 mv $RNASEQ_ROOT/dist/java-se-8u40-ri/* $RNASEQ_ROOT/build

 #### gcc/6.4.0 install
 # compiles with system default gcc
 cd $RNASEQ_ROOT/dist/gcc-6.4.0;
 ./configure --prefix=$RNASEQ_ROOT/build --enable-shared  --enable-languages=c,c++,fortran;
$(which expect) <<EOD
spawn make
expect {
-re "Archive name" { exp_send ".\r" exp_continue  }
-re . { exp_continue  }
timeout { exp_continue }
eof { return 0 }
}
EOD
 make;
 make install;

 ###########################
 #### install distributables
 ###########################

 #### install zlib
 make_install zlib-1.2.11;

 #### install bzip2
 cd $RNASEQ_ROOT/dist/bzip2-1.0.6;
 ./configure --enable-shared --prefix=$RNASEQ_ROOT/build;
 make -f Makefile-libbz2_so;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;
 cp libbz2.so.1.0.6 $RNASEQ_ROOT/build/lib/;
 cd $RNASEQ_ROOT/build/lib;
 ln -s libbz2.so.1.0.6 libbz2.so.1.0;

 #### install xz
 make_install xz-5.2.4;

 #### install pcre
 cd $RNASEQ_ROOT/dist/pcre-8.39;
 ./configure --enable-utf8 --prefix=$RNASEQ_ROOT/build --disable-cpp 
 --enable-shared
 make;
 make install PREFIX=$RNASEQ_ROOT/build;

 #### install htslib
 cd $RNASEQ_ROOT/dist/htslib-1.8;
 autoreconf -f;
 make_install htslib-1.8;

 #### install samtools
 cd $RNASEQ_ROOT/dist/samtools-1.8;
 autoreconf -f;
 make_install samtools-1.8; 

 ####python installation
 cd $RNASEQ_ROOT/dist/Python-2.7.15;
 ./configure --prefix=$RNASEQ_ROOT/build --enable-shared;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;
 cd $RNASEQ_ROOT/dist/setuptools-39.2.0;
 python bootstrap.py
 make_install_python setuptools-39.2.0;
 make_install_python cython-0.28.3;
 make_install_python swig-re-3.0.12;
 make_install_python numpy-1.14.5;
 make_install_python pysam-0.14.1;
 make_install_python htseq-release_0.9.1;

 #### install STAR
 make_install STAR-2.5.3a/source; 
 mv $RNASEQ_ROOT/dist/STAR-2.5.3a/bin/STAR $RNASEQ_ROOT/build/bin;

 #### install boost
 cd $RNASEQ_ROOT/dist/boost_1_55_0;
 ./bootstrap.sh
 ./b2
 ./b2 install --prefix=$RNASEQ_ROOT/build

 #### install tbb
# cd $RNASEQ_ROOT/build/tbb-2018_U4;
# gmake;
# mv build/`echo $(gmake info | tail -n1 | sed 's/^.*=//g')_release` $RNASEQ_ROOT/build;
# mv build/`echo $(gmake info | tail -n1 | sed 's/^.*=//g')_debug` $RNASEQ_ROOT/build;
# mv include $RNASEQ_ROOT/build;

 #### install spdlog
# mkdir -p $RNASEQ_ROOT/dist/spdlog-0.17.0/build;
# cd $RNASEQ_ROOT/dist/spdlog-0.17.0/build;
# cmake -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
# make;
# make install PREFIX=$RNASEQ_ROOT/build;
 
 #### install jemalloc
# cd $RNASEQ_ROOT/dist/jemalloc-5.1.0;
# autoreconf -f;
# ./configure --prefix=$RNASEQ_ROOT/build
# make;
# touch doc/jemalloc.html;
# touch doc/jemalloc.3;
# make install_doc_html;
# make install PREFIX=$RNASEQ_ROOT/build;
 
 #### install ruby
 make_install ruby-2.5.1;

 #### install yaggo
# make_install yaggo-1.5.10;
 
 #### install jellyfish
# cd $RNASEQ_ROOT/dist/Jellyfish-2.2.6;
# autoreconf -i;
# make_install Jellyfish-2.2.6;
 
 ### install bwa
# make_install bwa-0.7.17;
# cp -r $RNASEQ_ROOT/dist/bwa-0.7.17/* $RNASEQ_ROOT/build/bin;
 
 #### install cereal
# mkdir -p $RNASEQ_ROOT/dist/cereal-1.2.2/build;
# cd $RNASEQ_ROOT/dist/cereal-1.2.2/build;
# cmake -DBoost_DIR=$RNASEQ_ROOT/build -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
# make;
# make install PREFIX=$RNASEQ_ROOT/build;
 
 #### install salmon
 mkdir -p $RNASEQ_ROOT/dist/salmon-0.9.1/new;
 cd $RNASEQ_ROOT/dist/salmon-0.9.1/new;
 cmake -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
 #cmake -DBZIP2_INCLUDE_DIR=$RNASEQ_ROOT/build/include -DBZIP2_LIBRARY_RELEASE=$RNASEQ_ROOT/build/lib/libbz2.a -DZLIB_INCLUDE_DIR=$RNASEQ_ROOT/build/include -DZLIB_LIBRARY_RELEASE=/scratch/mforde/rnaseq_workflow_gardner/build/lib/libz.a -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;

 #### CRAN installation
 make_install curl-7.60.0; 
 make_install R-3.5.0;

 #### clean up packages distributables
 cd $RNASEQ_ROOT;
# rm -rf $RNASEQ_ROOT/dist;

#fi
