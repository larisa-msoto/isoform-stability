# Alternative splicing 

## Modeling isoform stability 

This part of the project focused on analyzing the differences in mRNA stability between different isoforms of the same gene. The data set analyzed came from a time series experiment in which the authors did RNA seq after metabolic labeling of RNA and transcription blockage of two cell lines: LM2 and MDA. MDA is a breast cancer cell line, and LM2 is it's highly metastatic derivative. The dataset is available here: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE49608 and the original paper is this one: https://pubmed.ncbi.nlm.nih.gov/25043050/).

## Overview of the analysis pipeline 

* Obtaining isoform-level count matrices - Salmon 
* Estimating mRNA stability with a linear model - DESeq2
* Comparing pairs of isoforms
  * **Isoforms with different differential stability isoforms between cell lines** - Computing a Wald test for pairs of isoforms using the estimations of Log2FoldChange and lfcSE from DESeq2 as population's mean and standard error, respectively.  
  
  * **Comparing differences in baselina stability between groups of isoforms** - It starts with classifying isoforms of every gene in short and long groups bbased on transcript length, 3' UTR length or 5' UTR length. Once the groups are formed, a paired T-test is performed on the estimates of baseline stability of the long and short groups.   
  
  * **Modeling mRNA stability as a function of isoform properties** - Fixed effect models using baseline or differential stabiblity estimates as the response variable of a linear model with parameters for transcript length, 3'UTR length, 5'UTR length and GC content.


