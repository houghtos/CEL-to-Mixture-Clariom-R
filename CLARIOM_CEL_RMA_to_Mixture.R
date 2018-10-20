#Install the following libraries.  
#Ensure the following libraries are installed.  

library(affy)
library(annotate)
library(org.Hs.eg.db)
library(oligo)
library(limma)
library(affycoretools) 
library(annotate)
library(annotationTools)

#Set directory which your cell files are in:
setwd('/home/users/jdoe/affymetrix/project_1/')

#Read cel files. Choose between what level (target) you wish to use.
list.celfiles()
dat <- read.celfiles(list.celfiles())
eset<-rma(dat)
#eset<-rma(Data, target = "probeset")
#eset<-rma(Data, target = "core")
#eset<-rma(Data, target = "full")
#eset<-rma(Data, target = "extended")



###### Check your annotation package by examining the "est" object. Ensure it is installed as such
# Example if "Annotation: pd.clariom.d.human"
#source("http://bioconductor.org/biocLite.R")
#biocLite("pd.clariom.d.human")
#libary(pd.clariom.d.human)

eset <- annotateEset(eset, pd.clariom.d.human)
#eset <- annotateEset(eset, pd.clariom.d.human, type = "probeset")
#eset <- annotateEset(eset, pd.clariom.d.human, type = "core")
#eset <- annotateEset(eset, pd.clariom.d.human, type = "full")
#eset <- annotateEset(eset, pd.clariom.d.human, type = "extended")

#Generate feature data
featureData(eset)
exprDat <- as.data.frame(exprs(eset))

#Combine feature data with expression matrix and remove unnecessary rows.
fdat <- fdat <- as.data.frame(fData(eset))
mixture <- cbind(fdat, exp_vals)
mixture <- mixture[ , -which(names(mixture) %in% c("PROBEID","ID","GENENAME"))]

#Per CIBERSORT, drop NA gene symbols and order by gene symbol ascending.
mixture <- mixture[which(mixture[,1] != "NA"),]
mixture <- mixture[order(mixture[,1]),]

#Write mixture file for analysis:
write.table(mixture,file="RMA_Mixture_File.txt",sep="\t", col.names=T, row.names=F,quote=FALSE)









