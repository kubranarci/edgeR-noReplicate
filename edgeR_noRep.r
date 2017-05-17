#edgeR code to run in SevenBridges platform, takes no replicate
#dispersion is handgiven
#usage.....
#CountTable.txt 1. CONTROL 2. SAMPLE
# edgeR_noRep.R INPUT_CountTable.txt  dispersion  FDR_value_up FDR_value_down  P_value  UP_regulated_file DOWN_regulated_file   All_file



args = commandArgs(trailingOnly=TRUE)
source("http://bioconductor.org/biocLite.R")
biocLite("lattice")
biocLite("edgeR")
library(lattice)
library(edgeR)
biocLite("org.Hs.eg.db")
library(org.Hs.eg.db)

#create count table
countsTable=read.delim(file=args[1],header=TRUE, row.names = 1)

mobDataGroups <- c("Mt", "Mu")
#specific to edgeR keep data in DGElist format
d <- DGEList(counts=countsTable ,group=factor(mobDataGroups))

#filering
d.full <- d # keep the old one in case we mess up
head(cpm(d))
apply(d$counts, 2, sum)
keep <- rowSums(cpm(d)>5) >= 2
d <- d[keep,]
dim(d)

d$samples$lib.size <- colSums(d$counts)
d$samples
#normalizing the data
d <- calcNormFactors(d)
d
#with no replicates dispersion need to be set up by user
disp= ARGS[2]

et <- exactTest(d, dispersion=disp)

pvaluesort <- topTags( et , n = nrow( et$table ) , sort.by = "p.value" )$table
head( pvaluesort )

pvaluesort $symbol <- mapIds(org.Hs.eg.db,
                             keys=row.names(pvaluesort ),
                             column="SYMBOL",
                             keytype="ENSEMBL",
                             multiVals="first")
pvaluesort $EntrezID <- mapIds(org.Hs.eg.db,
                               keys=row.names(pvaluesort ),
                               column="ENTREZID",
                               keytype="ENSEMBL",
                               multiVals="first")					 
pvaluesort $Unigene <- mapIds(org.Hs.eg.db,
                              keys=row.names(pvaluesort ),
                              column="UNIGENE",
                              keytype="ENSEMBL",
                              multiVals="first")						 					 

#data export

FDR_art=args[3]
FDR_eks=args[4]

P_value=args[5]

FDRsort= (pvaluesort)[pvaluesort$FDR <= P_value,] 
Psort= (FDRsort)[FDRsort$PValue <= P_value,] 

Upregule= (Psort  )[Psort $logFC>= FDR_art,] 
write.csv( Upregule, file=args[6] )
Downregule= (Psort  )[Psort $logFC<= FDR_eks,] 
write.csv( Downregule, file=args[7] )
y=rbind(Upregule,Downregule)
write.csv( y, file=args[8] )
