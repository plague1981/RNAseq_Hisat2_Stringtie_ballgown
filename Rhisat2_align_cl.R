# ======== Packages required =========
options(java.parameters = c("-XX:+UseConcMarkSweepGC", "-Xmx16384m"))
# Rcran
#$ sudo apt-get install libssl-dev (for installing 'openssl' package)
#$ sudo apt-get install libcurl4-gnutls-dev
#$ sudo apt-get install libxml2-dev

packages<-c('Xmisc','dplyr','R.utils','RCurl', 'openssl','XML')
for (package in packages){
  if(package %in% rownames(installed.packages()) == FALSE) {
    install.packages(package)}
}
# Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
bio.packages<-c("Rhisat2",'Rsamtools')
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
parser$add_argument('--i', type = 'character', default = 'hg', help = '"index",basename of your index')
parser$add_argument('--t', type = 'character', default = 'single', help = "c('single','paired')")
parser$helpme()

# === variables ====
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
fastqgz_files <- list.files(dirPath,pattern = "fastq.gz$")

# ==== align function  =====
library(Rhisat2)
require(dplyr)
require(Rsamtools)
require(R.utils)
for (n in 1:length(fastqgz_files)){
  cat(paste0('Processing ',fastqgz_files[n],'...'))
  gunzip(fastqgz_files[n] ) %>% hisat2(sequences =  , index= i, type= t, outfile=file.path(dir, paste0(fastqgz_files[n],".sam")), force = TRUE)
  cat('Done!\n')
  cat(paste0('Recompressing '),sub('fastq.gz','fastq',fastqgz_files[n]),'...')
  gzip(sub('fastq.gz','fastq',fastqgz_files[n]))
  cat('Done!\n')
  cat(paste0('Converting ', paste0(fastqgz_files[n],".sam"), ' to ',paste0(fastqgz_files[n],".bam...")))
  asBam(file =paste0(fastqgz_files[n],".sam"), destination =sub('fastq.gz','',fastqgz_files[n]))
  cat('Done!\n')
  file.remove(paste0(fastqgz_files[n],".sam"))
}
