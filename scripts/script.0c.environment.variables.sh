#!/bin/bash

#### set general env variables for software installation
export PATH=$RNASEQ_ROOT/build/bin:$PATH;
export JAVA_HOME=$RNASEQ_ROOT/build;
export PYTHONPATH=$RNASEQ_ROOT/build;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib64:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib/gcc/x86_64-unknown-linux-gnu/6.4.0:$LD_LIBRARY_PATH;
export CPATH=$RNASEQ_ROOT/build/include:$CPATH;
export CPATH=$RNASEQ_ROOT/build/include/python2.7:$CPATH;
export CC="gcc";
export FC="gfortran";
export F90="gfortran";
export F77="gfortran";
export CPP="gcc -E";
export CXX="g++";
export LC_ALL="en_US.UTF-8";
export CFLAGS="-fPIC"
export BOOST_ROOT=$RNASEQ_ROOT/build
export TBB_INSTALL_DIR=$RNASEQ_ROOT/build/$RELLOC;
export TBB_INCLUDE=$TBB_INSTALL_DIR/include;
export TBB_LIBRARY_RELEASE=$RNASEQ_ROOT/build/$RELLOC;
export TBB_LIBRARY_DEBUG=$RNASEQ_ROOT/build/$DEBLOC;
