#!/bin/bash

#### sources
source $RNASEQ_ROOT/scripts/script.0a.functions.sh;
source $RNASEQ_ROOT/scripts/script.0b.environment.variables.sh;

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
 #./configure --enable-shared --prefix=$RNASEQ_ROOT/build;
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
 ./configure --enable-utf8 --prefix=$RNASEQ_ROOT/build --disable-cpp --enable-shared
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

 #### install ruby
 make_install ruby-2.5.1;

 #### install salmon
 mkdir -p $RNASEQ_ROOT/dist/salmon-0.9.1/new;
 cd $RNASEQ_ROOT/dist/salmon-0.9.1/new;
 cmake -DCMAKE_INSTALL_PREFIX=$RNASEQ_ROOT/build ..;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;

 #### perl5 installation
 cd $RNASEQ_ROOT/dist/perl-5.28.0;
 ./Configure -des -Dusethreads -Dcc=gcc -Dprefix=$RNASEQ_ROOT/build;
 make;
 cd $RNASEQ_ROOT/dist/perl-5.28.0/dist/IO/;
 sed -i 's/poll.h/sys\/poll.h/g' IO.c;
 gcc -c -D_REENTRANT -D_GNU_SOURCE -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 -Wall -Werror=declaration-after-statement -Werror=pointer-arith -Wextra -Wc++-compat -Wwrite-strings -O2   -DVERSION=\"1.39\" -DXS_VERSION=\"1.39\" -fPIC "-I../.." IO.c;
 cd $RNASEQ_ROOT/dist/perl-5.28.0;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;

 ####  install openssl
 cd $RNASEQ_ROOT/dist/openssl-1.1.1-pre8;
 ./config --prefix=$RNASEQ_ROOT/build --openssldir=$RNASEQ_ROOT/build;
 make;
 make install PREFIX=$RNASEQ_ROOT/build;

 #### install curl
 cd $RNASEQ_ROOT/dist/curl-7.60.0;
 ./configure --prefix=$RNASEQ_ROOT/build --with-ssl
 make;
 make install PREFIX=$RNASEQ_ROOT/build;
 
 #### CRAN installation
 make_install R-3.5.0;

 #### clean up packages distributables
 cd $RNASEQ_ROOT;
 rm -rf $RNASEQ_ROOT/dist;

fi
