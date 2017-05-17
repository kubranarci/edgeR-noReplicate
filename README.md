#edgeR code to run in SevenBridges platform, for RNA-seq results. Takes a gene table (unnormalised values) in a form of  Control vs Sample. This script is only for samples have no replicate. Dispersion must be hand giver or else 0.045 will be used. 


....usage.....

CountTable.txt  1. CONTROL 2. SAMPLE

edgeR_noRep.R INPUT_CountTable.txt  dispersion  FDR_value_up FDR_value_down  P_value  UP_regulated_file DOWN_regulated_file   All_file

Disregulated genes are annotated using R org.Hs.eg.db package, and only Ensembl Gene ID could be used as key 


