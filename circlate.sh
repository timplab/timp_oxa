#!/bin/bash


ml samtools
ml python/3.4.2
ml gcc/5.1.0


for i in 1 2 4 6 7 8 9 10 12 ;
do

    mkdir -p ~/work/oxa/$i.circlate
    ##scp -r smaug:/atium/Data/Nanopore/Analysis/170104_reassemble/canu/$i.nanopore ~/work/oxa/$i.circlate/$i.nanopore
    ##scp -r smaug:/atium/Data/Nanopore/Analysis/170104_reassemble/pilon/$i.pilon.fasta ~/work/oxa/$i.circlate/$i.pilon.fasta
    
    canufa=~/work/oxa/$i.circlate/$i.nanopore/$i.nanopore.contigs.fasta
    pilonfa=~/work/oxa/$i.circlate/$i.pilon.fasta
    readsfa=~/work/oxa/$i.circlate/$i.nanopore/$i.nanopore.correctedReads.fasta.gz
    canuout=~/work/oxa/$i.circlate/$i.canu_circ
    pilonout=~/work/oxa/$i.circlate/$i.pilon_circ

    if [ -d $canuout ] ; then
	rm -r $canuout
    fi

    if [ -d $pilonout ] ; then
	rm -r $pilonout
    fi
    
    circlator all --bwa_opts "-x ont2d" --assembler canu --merge_min_id 85 --merge_breaklen 1000 --threads 24 $pilonfa $readsfa $pilonout
    circlator all --bwa_opts "-x ont2d" --assembler canu --merge_min_id 85 --merge_breaklen 1000 --threads 24 $canufa $readsfa $canuout

    echo DONE WITH SAMPLE $i
    
done
