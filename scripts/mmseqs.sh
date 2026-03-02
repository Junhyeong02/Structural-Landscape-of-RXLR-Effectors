C=0.5

FASTA="../../RXLR_db/RXLR_seq.fasta"
INPUTDB="./db/RXLR.db"
OUTPUTDB="./cluster/RXLR.db"
TSV="./RXLR_cluster_v3.tsv"

mmseqs createdb $FASTA $INPUTDB
mmseqs cluster $INPUTDB $OUTPUTDB temp -c $C  --threads 72
mmseqs createtsv $INPUTDB $INPUTDB $OUTPUTDB $TSV 
