#EdgeR, requires replication, without replication dispersion cannot be estimated
#dispersion calculation can be done using housekeeping genes for same cell lines

#edgeR dispersion prediction code to run in SevenBridges platform

#prepare count_table for all counts for your cell line: count_matrix.txt

#ENSEMBL_GENE_ID	HDMSO	HALPHA	HBETA	H-S-ALPHA	H-S-BETA	HSOR
#ENSG00000000003	1133	918	953	1185	730	864
#ENSG00000000005	1	0	1	0	0	0
#ENSG00000000419	623	173	349	431	413	527

#prepare ENSEMBL_GENE_ID vs GENE_NAME table for your house keeping genes; house_keeping_genes.txt

#ENSEMBL_GENE_ID	GENE_NAME
#ENSG00000128513	POT1
#ENSG00000253729	PRKDC
#ENSG00000168539	CHRM1
#ENSG00000164924	YWHAZ

#usage.....

# edgeR_predict_dispersion.R house_keeping_genes.txt count_matrix.txt

args = commandArgs(trailingOnly=TRUE)

ensembl_gene_id = read.delim( file = args[1], sep="\t", header=T, stringsAsFactors = F)
count_matrix = read.delim( file = args[2], sep="\t", header=T, stringsAsFactors = F)

merged=merge(ensembl_gene_id,count_matrix, by="ENSEMBL_GENE_ID", all=FALSE)

source("http://bioconductor.org/biocLite.R")
biocLite("lattice")
biocLite("edgeR")
biocLite("RcppArmadillo")
biocLite("limma")

library(lattice)
library(edgeR)
library(RcppArmadillo)
library(limma)


#create count table
gene <- merged[1]
rownames(merged) <- gene[,1]
merged <- merged[,-1]
merged <- merged[,-1]


number=ncol(merged)

mobDataGroups <- c( as.integer(runif(as.integer(number/2), min = 1, max = (2))), as.integer(runif(as.integer(number/2), min = 2, max = (3))) )
#specific to edgeR keep data in DGElist format
d <- DGEList(counts=merged ,group=factor(mobDataGroups))
d <- calcNormFactors(d)
design <- model.matrix(~factor(mobDataGroups))
d <- estimateDisp(d,design)

d$common.dispersion
cat(d$common.dispersion)
write.table(d$common.dispersion, "dispertion.txt")
