
PDB="../../RXLR_db/RXLR_pdb/*.pdb"
INPUTDB="./db/RXLR_v3.db"
OUTPUTDB="./cluster/RXLR_v3.db"
TSV="./foldseek_RXLR_3.tsv"

foldseek createdb $PDB $INPUTDB --threads 72
foldseek cluster $INPUTDB $OUTPUTDB temp --tmscore-threshold 0.5 --alignment-type 1 --exact-tmscore 1 -s 7.5 -c 0.5 --threads 72
foldseek createtsv $INPUTDB $INPUTDB $OUTPUTDB $TSV --full-header 0

# foldseek result2profile $INPUTDB $INPUTDB $OUTPUTDB alignment