#!/bin/bash

#### set general env variables for software installation
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib64:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib:$LD_LIBRARY_PATH;
export LD_LIBRARY_PATH=$RNASEQ_ROOT/build/lib/gcc/x86_64-unknown-linux-gnu/6.4.0:$LD_LIBRARY_PATH;
export PATH=$RNASEQ_ROOT/build/bin:$PATH;
export CPATH=$RNASEQ_ROOT/build/include:$CPATH;
export CPATH=$RNASEQ_ROOT/build/include/python2.7:$CPATH; 
export PYTHONPATH=$RNASEQ_ROOT/build;
export CC="gcc";
export FC="gfortran";
export F90="gfortran";
export F77="gfortran";
export CPP="gcc -E";
export CXX="g++";
export LC_ALL="en_US.UTF-8";
