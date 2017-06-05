edgeR code to run in SevenBridges platform, for RNA-seq results. Takes a gene table (unnormalised values) in a form of  Control vs Sample. This script is only for samples have no replicate. Dispersion must be hand giver or else 0.045 will be used. 

edgeR_noRep.r

....usage.....

CountTable.txt  1. CONTROL 2. SAMPLE  

edgeR_noRep.R INPUT_CountTable.txt  dispersion  FDR_value_up FDR_value_down  P_value  UP_regulated_file DOWN_regulated_file   All_file

Disregulated genes are annotated using R org.Hs.eg.db package, and only Ensembl Gene ID could be used as key 

#prepare_countMatrix.pl is to prepare edgeR compatable CountTable.txt from count table results from HTSeq count results.


!This version is only applicable for GRCh38/hg38

edgeR_predict_dispersion.r

EdgeR, requires replication, without replication dispersion cannot be estimated
dispersion calculation can be done using housekeeping genes for same cell lines

edgeR dispersion prediction code to run in SevenBridges platform

. prepare count_table for all counts for your cell line: count_matrix.txt

#ENSEMBL_GENE_ID	HDMSO	HALPHA	HBETA	H-S-ALPHA	H-S-BETA	HSOR
#ENSG00000000003	1133	918	953	1185	730	864
#ENSG00000000005	1	0	1	0	0	0
#ENSG00000000419	623	173	349	431	413	527

. prepare ENSEMBL_GENE_ID vs GENE_NAME table for your house keeping genes; house_keeping_genes.txt

#ENSEMBL_GENE_ID	GENE_NAME
#ENSG00000128513	POT1
#ENSG00000253729	PRKDC
#ENSG00000168539	CHRM1
#ENSG00000164924	YWHAZ

....usage.....

edgeR_predict_dispersion.R house_keeping_genes.txt count_matrix.txt
