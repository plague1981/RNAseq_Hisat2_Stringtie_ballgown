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
bio.packages<-c("RNASeqRData", 'RNASeqR')
for (bio.package in bio.packages){
  if(bio.package %in% rownames(installed.packages()) == FALSE) {
    BiocManager::install(bio.package)}
}
# === setting environment ===
parser <- Xmisc::ArgumentParser$new()
parser$add_usage('RNASeqData_cl.R [options]')
parser$add_description('An executable R script parsing arguments from Unix-like command line.')
parser$add_argument('--h',type='logical', action='store_true', help='Print the help page')
parser$add_argument('--help',type='logical',action='store_true',help='Print the help page')
parser$add_argument('--dir', type = 'character', default = getwd(), help = '"directory",Enter your working directory')
parser$add_argument('--o', type = 'character', default = paste0(dir,'RNASeq_results'), help = '"directory",Enter your output directory')
parser$add_argument('--g', type = 'character', default = 'NULL', help = '"genome",the name of a FASTA-format file that includes the ref-erence sequences used in read mapping that produced the provided SAM/BAMfiles..')
parser$add_argument('--t', type = 'character', default = 'SE', help = "c('SE','PE')")
parser$helpme()
# === variables ====
dir<-'/media/joey/Backup/Vincent/'
o<-paste0(dir,'RNASeq_results')
g<-'GRCh38_latest_genomic'
t<-'SE'
dirPath <- dir
dirPath <-gsub ('\\\\','/',dirPath)
if (dir.exists(dirPath)){
  setwd(dirPath)
  cat(paste0("Setting ",dirPath," as the working directory\n"))
} else {
  cat("Output directory is not existing!\n")
  quit()
}
if (!dir.exists(o)){
  dir.create(o , recursive = TRUE)
}
if (g=='NULL'){g <-NULL}
rnaseq_result.path<-o
input_files.path<-dir
list.files(input_files.path, recursive = TRUE)
sub('F','',list.files(input_files.path, recursive = TRUE))
# === Analysis function ===
library(RNASeqR)
library(RNASeqRData)

exp <- RNASeqRParam(path.prefix = rnaseq_result.path, 
                    input.path.prefix = input_files.path, 
                    genome.name = g, 
                    sample.pattern = 'F*_R',
                    independent.variable = "state", 
                    case.group = 'FP', 
                    control.group = "FN",
                    fastq.gz.type = t)
show(exp)
list.files(paste0(input_files.path,"input_files/raw_fastq.gz/"))
RNASeqEnvironmentSet(exp)
RNASeqQualityAssessment(exp)
Update_Fastq_gz(RNASeqRParam = exp, prepared_fastq_gz = paste0(input_files.path,"input_files/raw_fastq.gz/"), target_samples = "ALL")
RNASeqReadProcess(exp)
