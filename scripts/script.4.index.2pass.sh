#!/bin/bash

for f in *g37*1stpass*SJ.out.tab; do
 cat $f >> g37.merge.sj.out
done

for f in *g38*1stpass*SJ.out.tab; do
 cat $f >> g38.merge.sj.out
done

qsub script.4a.index.g37.2pass.pbs
qsub script.4b.index.g38.2pass.pbs

exit 0
