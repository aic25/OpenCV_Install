#!/bin/bash

ipp_file=ippicv_2017u3_lnx_intel64_general_20180518.tgz &&
ipp_hash=$(md5sum $ipp_file | cut -d" " -f1) &&
ipp_dir=.cache/ippicv                           &&

mkdir -p $ipp_dir &&
cp $ipp_file $ipp_dir/$ipp_hash-$ipp_file


