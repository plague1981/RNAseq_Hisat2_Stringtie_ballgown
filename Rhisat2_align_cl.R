# ======== Packages required =========
options(java.parameters = c("-XX:+UseConcMarkSweepGC", "-Xmx16384m"))
# Rcran
packages<-c('Xmisc')
for (package in packages){
  if(package %in% rownames(installed.packages()) == FALSE) {
    install.packages(package)}
}
# Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
bio.packages<-c("Rhisat2")
for (bio.package in bio.packages){
  if(bio.package %in% rownames(installed.packages()) == FALSE) {
    BiocManager::install(bio.package)}
}

# === setting environment ===
parser <- Xmisc::ArgumentParser$new()
parser$add_usage('Rsubread_featureCount_cl.R [options]')
parser$add_description('An executable R script parsing arguments from Unix-like command line.')
parser$add_argument('--h',type='logical', action='store_true', help='Print the help page')
parser$add_argument('--help',type='logical',action='store_true',help='Print the help page')
parser$add_argument('--dir', type = 'character', default = getwd(), help = '"directory",Enter your working directory')

parser$helpme()

# === variables ====
dir<-'C:/Users/Changyi.Lin/Desktop/Vincent/merged'
dirPath <- dir
dirPath <-gsub ('\\\\','/',dirPath)
if (dir.exists(dirPath)){
  setwd(dirPath)
  cat(paste0("Setting ",dirPath," as the working directory\n"))
} else {
  cat("Output directory is not existing!\n")
  quit()
}
# ==== obtain read.fastq.gz files ====
library(R.utils)
fastqgz_files <- list.files(dirPath,pattern = "fastq.gz$")

# ==== align function  =====
library(Rhisat2)
require(dplyr)
require(Rsamtools)

for (n in 1:length(fastqgz_files)){
  gunzip(fastqgz_files[n] ) %>% hisat2(sequences =  , index='hg', type="single", outfile=file.path(dir, paste0(fastqgz_files[n],".sam")), force = TRUE) %>% asBam(file =  , destination =sub(".sam", ".bam",x =  ))
  
  file.remove(paste0(fastqgz_files[1],".sam"))
}
