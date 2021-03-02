
library("tximport")
library("GenomicFeatures")

# IPUTS


outdir<-"../data/salmon_GSE49608/count_matrices/"
metadat<-"../data/metadata_GSE49608/sra-accession-samples.csv"
gtf<-"../data/references/gencode_GRCh38.12/gencode.v30.annotation.gtf"
txdb.filename<-"../data/references/gencode_GRCh38.12/gencode.v30.annotation.sqlite"

# MAIN 

print("Reading sample metadata...")
samp.info<-read.csv(metadat,row.names=1,header=T)

# Building transcript databse
################################################

if(file.exists(txdb.filename)){
	print(paste("Loading existing database for",txdb.filename))
	txdb <- loadDb(txdb.filename)
} else{
	print("Creating transcript-gene database from gtf file...")
	txdb <- makeTxDbFromGFF(gtf)
	saveDb(txdb, txdb.filename)
}
txdf <- as.data.frame(select(txdb, keys(txdb, "GENEID"), "TXNAME", "GENEID"))
txdf <- txdf[,c("TXNAME","GENEID")]


#Writing txi objects
################################################

modes<-c("gcBias","gcBias_seqBias")
for(mode in modes){

	inpdir<-paste("../data/salmon_GSE49608/quant_",mode,sep="")
	print("=============Input directory============")
	print(inpdir)

	#Reading sample metadata

	print("Reading sample files")
	files<-file.path(inpdir,rownames(samp.info),"quant.sf")

	#Build tximport object
	print("Reading files from input directory...")
	txi <- tximport(files, 
					type="salmon", 
					tx2gene=txdf,
	                countsFromAbundance="scaledTPM")

	#Save tximport object
	objpath<-paste("../data/salmon_GSE49608/objects/txi_",mode,".RData",sep="")
	print(paste("Writing object to:",objpath))
	save(txi,file=objpath)
}



#print("Writing txtimport object")
#print("Writing count matrix..")
#salmon_counts<-txi$counts[rowSums(txi$counts)>0,]
#colnames(salmon_counts)<-paste(samp.info$Cell_Line,"|R_",samp.info$Rep,"|T_",samp.info$Time.point,sep="")
#outfile<-paste(outdir,mode,"_scaledTPM.csv",sep="")
#write.csv(salmon_counts,file=outfile)

#print("Writing abundance matrix..")
#salmon_counts<-txi$abundance[rowSums(txi$abundance)>0,]
#colnames(salmon_counts)<-paste(samp.info$Cell_Line,"|R_",samp.info$Rep,"|T_",samp.info$Time.point,sep="")
#outfile<-paste(outdir,mode,"_abundance.csv",sep="")
#write.csv(salmon_counts,file=outfile)




