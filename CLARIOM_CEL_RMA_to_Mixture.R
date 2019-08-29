#Ensure relevant libraries are installed.

#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("affxparser")

library(affxparser)

#Place all .chp files ALONE in their own directory for simplicity sake.
#Can additionally add grep command e.g. grep("*\.chp$, directoryContents) to filter for only .chp files on chpList variable

setwd('/Users/jDoe/Documents/projects/Affymetrix1/chpFiles')
chpList <- list.files()

#Initialize data frame of first .chp in chpList with probe names and it's quantification value
sample<-strsplit(chpList[1], "[.]")[[1]][1]
dat=readChp(chpList[1],withQuant = TRUE)
unformated_signal = dat[['QuantificationEntries']]
x = data.frame(ProbeSetName=unformated_signal$ProbeSetName, sample=unformated_signal$QuantificationValue)
colnames(x)[colnames(x)=='sample']<-sample

#Loop over all additional .chp files and merge their quantification values on probe names.
for (i in 2:length(chpList)){
  sample<-strsplit(chpList[i], "[.]")[[1]][1]
  dat=readChp(chpList[i],withQuant = TRUE)
  unformated_signal = dat[['QuantificationEntries']]
  rma_signal = data.frame(ProbeSetName=unformated_signal$ProbeSetName, sample=unformated_signal$QuantificationValue)
  colnames(rma_signal)[colnames(rma_signal)=='sample']<-sample
  x<-merge(x,rma_signal, by='ProbeSetName')
}

#Set probe names as the data frame's row names and remove probe names as a column
rownames(x)<-x[,1]
x<-x[,-1]

#### You can now proceed with analysis. 
#### A good resource for limma differential expression: https://wiki.bits.vib.be/index.php/Analyze_your_own_microarray_data_in_R/Bioconductor



