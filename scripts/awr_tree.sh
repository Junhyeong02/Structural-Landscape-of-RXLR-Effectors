#!/bin/bash

mafft --thread 64 --maxiterate 1000 --globalpair ../2.sequence_feature/awr.fasta > awr.align.fasta 

# Strategy:
#  G-INS-i (Suitable for sequences of similar lengths, very slow)
#  Iterative refinement method (<16) with GLOBAL pairwise alignment information

trimal -in awr.align.fasta -out awr.align.75.fa -gt 0.75
trimal -in awr.align.fasta -out awr.align.60.fa -gt 0.60
trimal -in awr.align.fasta -out awr.align.50.fa -gt 0.50
trimal -in awr.align.fasta -out awr.align.25.fa -gt 0.25
trimal -in awr.align.fasta -out awr.align.10.fa -gt 0.10
trimal -in awr.align.fasta -out awr.align.20.fa -gt 0.20
trimal -in awr.align.fasta -out awr.align.15.fa -gt 0.15
trimal -in awr.align.fasta -out trim30/awr.align.30.fa -gt 0.30

# nohup iqtree -s awr.align.fasta -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > iqtree.log &
nohup iqtree -s trim10/awr.align.10.fa -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > trim10/iqtree.log &
nohup iqtree -s trim20/awr.align.20.fa -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > trim20/iqtree.log &
nohup iqtree -s trim30/awr.align.30.fa -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > trim30/iqtree.log &
nohup iqtree -s trim50/awr.align.50.fa -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > trim50/iqtree.log &
nohup iqtree -s trim75/awr.align.75.fa -alrt 1000 -bb 1000 -nt AUTO -ntmax 64 -safe > trim75/iqtree.log &

